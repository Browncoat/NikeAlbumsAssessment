//
//  AlbumsListPresenter.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import Foundation

class AlbumsListPresenter {
    var viewController: AlbumsListViewController?
    
    init(viewController: AlbumsListViewController) {
        self.viewController = viewController
    }
    
    func present(results: [Album]) {
        let displayAlbums = results.map{ AlbumsModels.DisplayAlbum(name: $0.name, artist: $0.artist, albumArtworkUrl: $0.albumArtworkUrl, genres: $0.genres.reduce("", { $0 + ($0.count > 0 ? ", " : "") + $1.name }), copyright: $0.copyright, releaseDate: DateFormatter.yyyyMMdd.string(from: $0.releaseDate), albumUrl: $0.url, thumbnail: nil) }
        let viewModel = AlbumsModels.ViewModel(albums: displayAlbums)
        
        display(viewModel: viewModel)
    }
    
    func present(error: Error) {
        viewController?.display(error: error)
    }
    
    func display(viewModel: AlbumsModels.ViewModel) {
        viewController?.display(viewModel: viewModel)
    }
}
