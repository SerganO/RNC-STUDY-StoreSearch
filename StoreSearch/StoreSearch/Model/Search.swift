//
//  Search.swift
//  StoreSearch
//
//  Created by Trainee on 2/26/19.
//  Copyright © 2019 Trainee. All rights reserved.
//


import Foundation
import UIKit

typealias SearchComplete = (Bool) -> Void



class Search
{
    enum Category: Int
    {
        case all = 0
        case music = 1
        case software = 2
        case ebooks = 3
        
        var type: String
        {
            switch self
            {
            case .all: return ""
            case .music: return "musicTrack"
            case .software: return "software"
            case .ebooks: return "ebook"
            }
        }
    }
    
    enum State
    {
        case notSearchedYet
        case loading
        case noResults
        case results([SearchResult])
    }
    
    private var dataTask: URLSessionDataTask? = nil
    private(set) var state: State = .notSearchedYet
    
    
    func performSearch(for text: String, category: Category, completion: @escaping SearchComplete)
    {
        if !text.isEmpty
        {
            dataTask?.cancel()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            state = .loading
            
            let url = iTunesURL(searchText: text, category: category)
            
            let session = URLSession.shared
            dataTask = session.dataTask(with: url, completionHandler:
            {
                data, responce, error in
                var success = false
                var newState = State.notSearchedYet
                if let error = error as NSError?, error.code == -999
                {
                    return
                }
                
                if let httpResponce = responce as? HTTPURLResponse, httpResponce.statusCode == 200, let data = data
                {
                    var searchResult = self.parse(data: data)
                    if searchResult.isEmpty
                    {
                        newState = .noResults
                    }
                    else
                    {
                        searchResult.sort(by: <)
                        newState = .results(searchResult)
                    }
                    success = true
                    
                }
                DispatchQueue.main.async
                {
                    self.state = newState
                    completion(success)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
                
            })
            dataTask?.resume()
            
            }
    }
    
    
    private func iTunesURL(searchText: String, category: Category) -> URL
    {
        let locale = Locale.autoupdatingCurrent
        let language = locale.identifier
        let countryCode = locale.regionCode ?? "en_US"

        
        let kind = category.type
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = "https://itunes.apple.com/search?" +
        "term=\(encodedText)&limit=200&entity=\(kind)" +
        "&lang=\(language)&country=\(countryCode)"
        
        let url = URL(string: urlString)
        print("URL: \(url!)")
        return url!
    }
    
    
    
    private func parse(data: Data) -> [SearchResult]
    {
        do
        {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self,from: data)
            return result.results
        }
        catch
        {
            print("JSON Error: \(error)")
            return []
        }
    }
    
}


/*func performSearch() {
 if !searchBar.text!.isEmpty
 {
 searchBar.resignFirstResponder()
 dataTask?.cancel()
 isLoading = true
 tableView.reloadData()
 
 //hasSearched = false
 hasSearched = true
 searchResults = []
 
 let url = iTunesURL(searchText: searchBar.text!, category: segmentedControl.selectedSegmentIndex)
 
 let session = URLSession.shared
 
 dataTask = session.dataTask(with: url, completionHandler:
 {
 data, response, error in
 if let error = error as NSError?, error.code == -999
 {
 print("************* \(error.domain)")
 return
 }
 else if let httpResponse = response as? HTTPURLResponse,
 httpResponse.statusCode == 200
 {
 if let data = data
 {
 
 self.searchResults = self.parse(data: data)
 self.searchResults.sort(by: <)
 DispatchQueue.main.async
 {
 self.isLoading = false
 self.tableView.reloadData()}
 return
 }
 }
 else
 {
 print("Failure! \(response!)")
 }
 DispatchQueue.main.async {
 self.hasSearched = false
 self.isLoading = false
 self.tableView.reloadData()
 self.showNetworkError()
 }
 })
 dataTask?.resume()
 }
 }
 
 */
