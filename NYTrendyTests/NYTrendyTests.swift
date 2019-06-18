//
//  NYTrendyTests.swift
//  NYTrendyTests
//
//  Created by Mac on 6/17/19.
//  Copyright © 2019 onaissi. All rights reserved.
//

import XCTest
@testable import NYTrendy
@testable import Alamofire

class NYTrendyTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArticle() {
        let date = Date()
        guard let url = URL(string: "www.google.com") else{
            assert(false)
        }
      let article = Article(title: "title", section: "section", publishDate: date, byLine: "byLine", abstract: "abstract", url: url, source: "source", imageUrl: "image")
        
        XCTAssertNotNil(article)
        XCTAssertEqual(article.title, "title")
        XCTAssertEqual(article.publishDate, date)
        XCTAssertEqual(article.section, "section")
        XCTAssertEqual(article.byLine, "byLine")
        XCTAssertEqual(article.abstract, "abstract")
        XCTAssertEqual(article.url.absoluteString, url.absoluteString)
        XCTAssertEqual(article.source, "source")
        XCTAssertEqual(article.imageUrl, "image")
       
    }

    func testNetworkCall(){
        let promise = expectation(description: "200 OK response")
        
        let urlString = Constants.BASE_URL + ArticleLinks.LATEST_ARTICLES.rawValue
        
        let params = ["api-key" : Constants.API_KEY]
        Alamofire.request(urlString, method:.get, parameters: params, encoding:URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                
                let statusCode = response.response?.statusCode
                
                // check for errors
                guard response.result.error == nil else {
                   XCTFail("error found while requesting")
                    return
                }
                
                //make sure we got some JSON
                guard response.result.isSuccess, let _ = response.result.value as? [String: Any] else{
                    print("Error: \(String(describing: response.result.error))")
                    XCTFail("error found while requesting")
                    return
                }
                //SUCCESS
                if statusCode == HttpCode.SUCCESS.rawValue{
                    promise.fulfill()
                }else{
                    XCTFail("status code is not 200")
                }
                    
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
