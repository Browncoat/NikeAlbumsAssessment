//
//  Library.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import Combine

class Library: Librariable {
    let client: Requestable
    
    init(client: Requestable) {
        self.client = client
    }
    
    func getItems<T>(ofType: T.Type, at path: String) -> AnyPublisher<T, Error> where T: Decodable {
        // Could intercept and save to a persistent store here as well
        return client.getResource(at: path)
    }
}
