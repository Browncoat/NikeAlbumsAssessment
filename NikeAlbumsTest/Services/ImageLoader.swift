//
//  ImageLoader.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import UIKit
import Combine

enum ImageLoadError: Error {
    case invalidPath
    case downloadError
    case deserializeError
}

class ImageLoader {
    static let shared = ImageLoader()
    
    let cachedImages = NSCache<NSString, UIImage>()
            
    func loadImage(path: String) -> AnyPublisher<UIImage?, URLError> {
        guard let url = URL(string: path) else {
            let error = URLError(.badURL, userInfo: [NSURLErrorKey: path])
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        if let image = cachedImages.object(forKey: url.absoluteString as NSString) {
            return Just(image)
                .setFailureType(to: URLError.self)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { value in
                let image = UIImage(data: value.data)
                self.cachedImages.setObject(image!, forKey: value.response.url!.absoluteString as NSString)
                return image
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
