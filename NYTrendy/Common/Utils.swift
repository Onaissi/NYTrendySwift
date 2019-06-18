//
//  Utils.swift
//  NYTrendy
//
//  Created by Mac on 6/17/19.
//  Copyright © 2019 onaissi. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class Utils{
    
    public static func loadImage(urlString: String?, imageView: UIImageView){
        imageView.image = nil
        if let urlString = urlString{
            let url = URL(string: urlString)
            if let url = url{
                let filter = AspectScaledToFitSizeFilter(size: imageView.frame.size)
                imageView.af_setImage(withURL: url, placeholderImage: nil, filter: filter)
            }
        }
    }
}
