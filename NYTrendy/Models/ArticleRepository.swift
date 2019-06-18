//
//  ArticleRepository.swift
//  NYTrendy
//
//  Created by Mac on 6/17/19.
//  Copyright © 2019 onaissi. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

enum ArticleLinks: String{
    case LATEST_ARTICLES = "mostpopular/v2/viewed/7.json"
}

class ArticleRepository : Repository{
    
    var articleDelegate: ArticleDelegate
    
    init(controller: UIViewController, delegate: ArticleDelegate) {
        self.articleDelegate = delegate
        super.init(controller: controller)
    }
    
    
    
    
    
    
    func requestLatestArticles(){
        let urlString = Constants.BASE_URL + ArticleLinks.LATEST_ARTICLES.rawValue
       
        let params = ["api-key" : Constants.API_KEY]
        
        showProgressDialog()
        Alamofire.request(urlString, method:.get, parameters: params, encoding:URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(String(describing: response.result.value))")
                
                let statusCode = response.response?.statusCode
                print("status code: \(String(describing: statusCode))")
                
                // check for errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling request" )
                    print(response.result.error!)
                    self.processFailedResponse(handler: { (_) in
                        self.requestLatestArticles()
                    })
                    return
                }
                
                //make sure we got some JSON
                guard response.result.isSuccess, let json = response.result.value as? [String: Any] else{
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                //SUCCESS
                if statusCode == HttpCode.SUCCESS.rawValue{
                self.hideProgressDialog()
                let articleList = self.parseArticleList(json)
                    //call delegate
                    self.articleDelegate.fetchLatestArticles(articleList: articleList)
                }else{
                    self.processFailedResponse(handler: { (_) in
                      self.requestLatestArticles()
                    })
                }
        }
    }
    
    
    
    
    
    
    
    //parse single article
    func parseArticleJSON(_ data: JSON) -> Article?{
        let urlString = data["url"].stringValue
        let url = URL(string: urlString)
        
        var imageUrl: String?
        
        let media = data["media"].arrayValue
        for mediaItem in media{
            if mediaItem["type"] == "image"{
                for metaItem in mediaItem["media-metadata"].arrayValue{
                    if metaItem["format"].stringValue == "Standard Thumbnail"{
                       imageUrl = metaItem["url"].stringValue
                    }
                }                
            }
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.date(from: data["published_date"].stringValue)
        guard let publishDate = date, let articleUrl = url else{
            print("ArticleRepository:: parseArticel: date is nil")
            return nil
        }
        return Article(title: data["title"].stringValue, section: data["section"].stringValue, publishDate: publishDate, byLine: data["byline"].stringValue, abstract: data["abstract"].stringValue, url: articleUrl, source: data["source"].stringValue, imageUrl: imageUrl)
    }
    
    
    
    
    
    
    
    
    //parse list of articcles
    func parseArticleList(_ response: [String: Any]) -> [Article]{
        var articleList = [Article]()
        let data = JSON(response)
        for articleJson in data["results"].arrayValue{
            if let article = parseArticleJSON(articleJson){
                articleList.append(article)
            }
        }
        return articleList
    }
    
    
    
    
}
