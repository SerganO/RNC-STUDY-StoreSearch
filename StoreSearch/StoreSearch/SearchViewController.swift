//
//  ViewController.swift
//  StoreSearch
//
//  Created by Trainee on 2/20/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //__________ Outlet __________
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //__________ Variable __________
    
    var searchResults = [String]()
    

    //__________ Load __________
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }

}

//__________ Extension __________

extension SearchViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults = []
        for i in 0...2
        {
            searchResults.append(String(format:"Fake Result %d for '%@'", i, searchBar.text!))
        }
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "SearchResultCell"
        
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil
        {
            cell = UITableViewCell(style: .default,reuseIdentifier: cellIdentifier)
        }
        
        cell.textLabel!.text = searchResults[indexPath.row]
        return cell
    }
    
    
}
