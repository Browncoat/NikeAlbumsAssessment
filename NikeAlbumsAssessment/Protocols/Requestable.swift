//
//  Requestable.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import Combine

protocol Requestable {
    func getResource<T>(at path: String) -> AnyPublisher<T, Error> where T: Decodable
}
