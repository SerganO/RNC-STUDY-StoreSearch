//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Trainee on 2/21/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import Foundation

class ResultArray: Codable
{
    var resultCount = 0
    var results = [SearchResult]()
}

class SearchResult: Codable, CustomStringConvertible
{
    var kind: String? = ""
    var artistName: String? = ""
    var trackName: String? = ""
    
    var trackPrice: Double? = 0.0
    var currency = ""
    var imageSmall = ""
    var imageLarge = ""
    var storeURL: String? = ""
    var genre = ""
    
    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case storeURL = "trackViewUrl"
        case genre = "primaryGenreName"
        case kind, artistName, trackName
        case trackPrice, currency
    }
    
    var name:String
    {
        return trackName ?? ""
    }
    
    var description: String
    {
        return "Kind: \(kind ?? "None"), Name: \(name), Artist Name: \(artistName ?? "None")"
    }
}
