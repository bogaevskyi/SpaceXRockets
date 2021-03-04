//
//  ImageLoader.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 25.01.2021.
//

import Foundation
import Combine
import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    
    private let cache = NSCache<NSURL, UIImage>()
    private var cancellable = Set<AnyCancellable>()
    
    private var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Image Downloading Queue"
        queue.maxConcurrentOperationCount = 2
        queue.qualityOfService = .background
        return queue
    }()
    
    func getImage(url: URL) -> AnyPublisher<UIImage?, Never> {
        guard let cachedImage = cache.object(forKey: url as NSURL) else {
            return downloadImage(url: url)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        return Just(cachedImage).eraseToAnyPublisher()
    }
    
    // MARK: -
    
    private func downloadImage(url: URL) -> AnyPublisher<UIImage?, Never> {
        
        let imageOperations = queue.operations as? [ImageLoadingOperation]
        let existingOperation = imageOperations?.first {
            $0.imageURL == url && $0.isFinished == false
        }
        
        if let existingOperation = existingOperation {
            return existingOperation.$image.eraseToAnyPublisher()
        } else {
            let operation = ImageLoadingOperation(imageURL: url)
            queue.addOperation(operation)

            return operation.$image
                .map { [weak self] image in
                    self?.saveToCache(image: image, url: url)
                    return image
                }
                .eraseToAnyPublisher()
        }
    }
    
    private func saveToCache(image: UIImage?, url: URL) {
        if image == nil {
            cache.removeObject(forKey: url as NSURL)
        } else {
            cache.setObject(image!, forKey: url as NSURL)
        }
    }
}
