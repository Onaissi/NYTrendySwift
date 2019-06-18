//
//  ArticleDelegate.swift
//  NYTrendy
//
//  Created by Mac on 6/17/19.
//  Copyright © 2019 onaissi. All rights reserved.
//

import Foundation

protocol ArticleDelegate {
    func fetchLatestArticles(articleList: [Article])
}
