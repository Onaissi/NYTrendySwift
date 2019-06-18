//
//  MenuTableViewController.swift
//  NYTrendy
//
//  Created by Mac on 6/18/19.
//  Copyright © 2019 onaissi. All rights reserved.
//

import UIKit
import SideMenu

enum MenuItems: Int{
    case Home = 0
}

class MenuTableViewController: UITableViewController {

    var menuItems = ["Home"]
    static var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 75
        self.tableView.rowHeight = 75
        SideMenuManager.default.menuFadeStatusBar = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu_cell", for: indexPath)

        cell.textLabel?.text = menuItems[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == MenuItems.Home.rawValue{ //Home
            showNavigationController(index: MenuItems.Home.rawValue, identifier: "home_storyboard", storyboardIdentifier: nil)
            
        }
    }
    
    
    //MARK: - Helper functions
    func showNavigationController(index: Int, identifier: String, storyboardIdentifier: String? ){
        if MenuTableViewController.currentIndex != index{
            MenuTableViewController.currentIndex = index
            let storyboard = UIStoryboard(name: storyboardIdentifier ?? "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: identifier)
            show(vc, sender: self)
        }else{
            dismiss(animated: true, completion: nil)
        }
    }


}
