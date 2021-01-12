//
//  Librariable.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import Foundation
import Combine

protocol Librariable {
    func getItems<T>(ofType: T.Type, at path: String) -> AnyPublisher<T, Error> where T: Decodable
}
