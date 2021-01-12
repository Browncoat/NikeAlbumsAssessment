//
//  Album.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import UIKit

struct FeedResponse: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Album]
}

struct Album: Decodable {
    let artist: String
    let name: String
    let albumArtworkUrl: String
    let releaseDate: Date
    let genres: [Genre]
    let copyright: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case name = "name"
        case albumArtworkUrl = "artworkUrl100"
        case releaseDate = "releaseDate"
        case genres = "genres"
        case copyright = "copyright"
        case url = "url"
    }
}
