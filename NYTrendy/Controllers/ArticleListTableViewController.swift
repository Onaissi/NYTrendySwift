//
//  ArticleListTableViewController.swift
//  NYTrendy
//
//  Created by Mac on 6/17/19.
//  Copyright © 2019 onaissi. All rights reserved.
//

import UIKit

class ArticleListTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, ArticleDelegate {

    private var articleList = [Article]()
    private var filteredList = [Article]()
    private var searchController: UISearchController?;
    override func viewDidLoad() {
        super.viewDidLoad()
        let articleRepo = ArticleRepository(controller: self, delegate: self)
        articleRepo.requestLatestArticles()
         searchSetup();

    }

    //MARK - Actions
    
    @IBAction func didClickSearchBtn(_ sender: Any) {
        showSearchController()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            return filteredList.count
        }
        return articleList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell", for: indexPath) as! ArticleTableViewCell
        let article = getArticle(indexPath: indexPath)
        Utils.loadImage(urlString: article.imageUrl, imageView: cell.mainImageView)
        cell.titleLabel.text = article.title
        cell.bylineLabel.text = article.byLine
        cell.publishDateLabel.text = article.publishDateString()
        cell.sectionLabel.text = article.section
        
        return cell
    }
    

    //MARK: - Delegate
    func fetchLatestArticles(articleList: [Article]) {
        self.articleList = articleList
        self.tableView.reloadData()
    }
    

    func getArticle(indexPath: IndexPath) -> Article{
        if isFiltering(){
            return filteredList[indexPath.row]
        }
        return articleList[indexPath.row]
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "artcle_detail_segue"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let article = getArticle(indexPath: indexPath)
                if let articleDetailsVC = segue.destination as? ArticleDetailsViewController{
                    articleDetailsVC.article = article
                }
            }            
        }
    }
    
    
    //MARK - Search result delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText:searchController.searchBar.text)
    }
    
    //MARK: - Search controller
    func searchSetup(){
        searchController = UISearchController(searchResultsController: nil)
        if let uSearchController = searchController{
            uSearchController.searchResultsUpdater = self
            uSearchController.dimsBackgroundDuringPresentation = false
            uSearchController.definesPresentationContext = false
            uSearchController.hidesNavigationBarDuringPresentation = false
            uSearchController.searchBar.delegate = self
        }
    }
    
    func showSearchController(){
        if let uSearchController = searchController{
           present(uSearchController, animated: true, completion: nil)
        }
    }
    
    func hideSearchController(){
        if let uSearchController = searchController{
            uSearchController.isActive = false
        }
    }
    
    func searchBarEmpty() -> Bool{
        if let uSearchController = searchController, let a = uSearchController.searchBar.text, a.count != 0{
            return true
        }
        return false
    }
    
    
    func filterContentForSearchText(searchText:String?){
        filteredList = [Article]()
        let bufferArray = articleList.filter { (article) -> Bool in
            if let uSearchText = searchText, article.title.lowercased().contains(uSearchText.lowercased()){
                return true
            }
            return false
        }
        if !bufferArray.isEmpty{
            filteredList = bufferArray
        }
        self.tableView.reloadData()
    }
    
    
    func isFiltering() -> Bool{
        if let uSearchController = searchController{
            return uSearchController.isActive && searchBarEmpty()
        }
        return false
    }
    

}
