//
//  AlbumsModels.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import UIKit

enum AlbumsModels {
    // with more time I would construct the Request url from path components passed in to the Request constructor
    struct Request {
        let url: String
    }
    
    struct Response {
        let albums: [Album]
    }
    
    struct DisplayAlbum: Hashable {
        let name: String
        let artist: String
        let albumArtworkUrl: String
        let genres: String
        let copyright: String
        let releaseDate: String
        let albumUrl: String
        var thumbnail: UIImage?
    }
    
    struct ViewModel {
        let albums: [DisplayAlbum]
    }
    
    struct Error {
        let message: String
    }
}
