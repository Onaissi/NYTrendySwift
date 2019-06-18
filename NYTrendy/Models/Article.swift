//
//  Article.swift
//  NYTrendy
//
//  Created by Mac on 6/17/19.
//  Copyright © 2019 onaissi. All rights reserved.
//

import Foundation

class Article {
    
    var title:String
    var section: String
    var publishDate: Date
    var byLine: String
    var abstract: String
    var url: URL
    var source: String
    var imageUrl: String?
    
    init(title: String, section: String, publishDate: Date, byLine: String, abstract: String, url: URL, source: String, imageUrl: String?) {
        self.title = title
        self.section = section
        self.publishDate = publishDate
        self.byLine = byLine
        self.abstract = abstract
        self.url = url
        self.source = source
        self.imageUrl = imageUrl
    }
    
    func summary() -> String{
        var desc = self.section + "\n"
        desc += self.source + "\n"
        desc += self.byLine + "\n"
        desc += publishDateString()        
        return desc;
    }
    
    func publishDateString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.string(from: self.publishDate)
    }
}
