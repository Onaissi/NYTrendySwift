//
//  Repository.swift
//  NYTrendy
//
//  Created by Mac on 6/17/19.
//  Copyright © 2019 onaissi. All rights reserved.
//

import Foundation
import SVProgressHUD

class Repository{
    
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func showProgressDialog(){
       SVProgressHUD.show()
    }
    
    func hideProgressDialog(){
        SVProgressHUD.dismiss()
    }
    
    
    func processFailedResponse(handler: ((UIAlertAction) -> Void)?){
           hideProgressDialog()
            let alert = UIAlertController(title: "Failed", message: "Faield to connect to server. Make sure you are connected to the Internet", preferredStyle: .alert);
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let retryAction = UIAlertAction(title: "Retry", style: .default,handler: handler)
            alert.addAction(okAction)
            alert.addAction(retryAction)
            controller.present(alert, animated: true, completion: nil)
    }
    
}
