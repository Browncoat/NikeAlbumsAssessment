//
//  AlbumsListViewInteractor.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import UIKit
import Combine

class AlbumsListInteractor {
    let worker: Librariable
    var presenter: AlbumsListPresenter?
    
    var subscriber: AnyCancellable?
        
    init(library: Librariable) {
        worker = library
    }
    
    // With more time I would adding paging functionality to this class
    func fetch(request: AlbumsModels.Request) {
        subscriber = worker.getItems(ofType: FeedResponse.self, at: request.url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.presenter?.present(error: error)
                }
            }, receiveValue: { feedResponse in
                self.presenter?.present(results: feedResponse.feed.results)
            })
    }
}
