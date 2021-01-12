//
//  Client.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import Foundation
import Combine

class Client: Requestable {
    let urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rss.itunes.apple.com"
        
        return components
    }()
    
    let basePath = "/api/v1"

    func getResource<T>(at path: String) -> AnyPublisher<T, Error> where T: Decodable {
        var components = urlComponents
        components.path = urlComponents.path.appending(basePath).appending(path)
        guard let url = components.url else {
            let error = URLError(.badURL, userInfo: [NSURLErrorKey: path])
            return Fail(error: error)
                .eraseToAnyPublisher()
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
