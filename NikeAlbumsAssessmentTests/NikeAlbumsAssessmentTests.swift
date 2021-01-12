//
//  NikeAlbumsAssessmentTests.swift
//  NikeAlbumsTestTests
//
//  Created by Nate Potter on 1/11/21.
//

import XCTest
import Combine
@testable import NikeAlbumsAssessment

class NikeAlbumsAssessmentTests: XCTestCase {
    var cancellable: AnyCancellable?
    var interactor: AlbumsListInteractor?
    var viewController: MockViewController?

    override func setUpWithError() throws {
        viewController = MockViewController()
        interactor = AlbumsListInteractor(library: Library(client: MockClient<Feed>()))
        interactor?.presenter = AlbumsListPresenter(viewController: viewController!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testThatAlbumsCountIsCorrect() {
        //given
        interactor?.fetch(request: AlbumsModels.Request(url: ""))
        
        //when
        let viewModel = viewController?.viewModel
        
        //then
        XCTAssertEqual(viewModel?.albums.count, 1)
    }
    
    func testThatAlbumNameExists() {
        //given
        interactor?.fetch(request: AlbumsModels.Request(url: ""))
        
        //when
        let name = viewController?.viewModel?.albums.first?.name
        
        //then
        XCTAssertNotNil(name)
    }
    
    func testThatArtistNameExists() {
        //given
        interactor?.fetch(request: AlbumsModels.Request(url: ""))
        
        //when
        let artist = viewController?.viewModel?.albums.first?.artist
        
        //then
        XCTAssertNotNil(artist)
    }
    
    func testThatAlbumUrlExists() {
        //given
        interactor?.fetch(request: AlbumsModels.Request(url: ""))
        
        //when
        let url = viewController?.viewModel?.albums.first?.albumUrl
        
        //then
        XCTAssertNotNil(url)
    }
    
    func testThatAlbumArtworkUrlExists() {
        //given
        interactor?.fetch(request: AlbumsModels.Request(url: ""))
        
        //when
        let artWorkUrl = viewController?.viewModel?.albums.first?.albumArtworkUrl
        
        //then
        XCTAssertNotNil(artWorkUrl)
    }
    
    func testThatGenreExists() {
        //given
        interactor?.fetch(request: AlbumsModels.Request(url: ""))
        
        //when
        let genres = viewController?.viewModel?.albums.first?.genres
        
        //then
        XCTAssertNotNil(genres)
    }
    
    func testThatReleaseDateExists() {
        //given
        interactor?.fetch(request: AlbumsModels.Request(url: ""))
        
        //when
        let releaseDate = viewController?.viewModel?.albums.first?.releaseDate
        
        //then
        XCTAssertNotNil(releaseDate)
    }
    
    func testThatCopyrightExists() {
        //given
        interactor?.fetch(request: AlbumsModels.Request(url: ""))
        
        //when
        let copyright = viewController?.viewModel?.albums.first?.copyright
        
        //then
        XCTAssertNotNil(copyright)
    }
}

class MockViewController: AlbumsListDisplayable {
    var viewModel: AlbumsModels.ViewModel?
    
    func display(viewModel: AlbumsModels.ViewModel) {
        self.viewModel = viewModel
    }
    
    func display(error: Error) {
        //
    }
}

class MockClient<T>: Requestable where T: Decodable {
    let JSONString = """
    {
        "feed": {
            "title": "Top Albums",
            "copyright": "Copyright © 2018 Apple Inc. All rights reserved.",
            "country": "us",
            "icon": "http://itunes.apple.com/favicon.ico",
            "updated": "2021-01-10T04:49:36.000-08:00",
            "results": [{
                "artistName": "Morgan Wallen",
                "id": "1540314609",
                "releaseDate": "2021-01-08",
                "name": "Dangerous: The Double Album",
                "kind": "album",
                "copyright": "℗ 2020 Big Loud Records, under exclusive license to Republic Records, A division of UMG Recordings, Inc.",
                "artistId": "829142092",
                "contentAdvisoryRating": "Explicit",
                "artistUrl": "https://music.apple.com/us/artist/morgan-wallen/829142092?app=music",
                "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/4d/ac/86/4dac8685-540c-8401-ff8f-feb2b4b6c7c1/20UM1IM03632.rgb.jpg/200x200bb.png",
                "genres": [{
                    "genreId": "6",
                    "name": "Country",
                    "url": "https://itunes.apple.com/us/genre/id6"
                }, {
                    "genreId": "34",
                    "name": "Music",
                    "url": "https://itunes.apple.com/us/genre/id34"
                }],
                "url": "https://music.apple.com/us/album/dangerous-the-double-album/1540314609?app=music"
            }]
        }
    }
    """
        
    func getResource<T>(at path: String) -> AnyPublisher<T, Error> where T : Decodable {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        
        do {
            let feed = try decoder.decode(FeedResponse.self, from: JSONString.data(using: .utf8)!)
            
            return Just(feed as! T).setFailureType(to: Error.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
