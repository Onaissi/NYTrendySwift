//
//  ArticleDetailsViewController.swift
//  NYTrendy
//
//  Created by Mac on 6/18/19.
//  Copyright © 2019 onaissi. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    

    func updateViews(){
        if let article = article{
            self.titleLabel.text = article.title
            self.detailsLabel.text = article.summary()
            self.abstractLabel.text = article.abstract
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
