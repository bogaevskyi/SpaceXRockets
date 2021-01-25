//
//  ImageLoader.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 25.01.2021.
//

import Alamofire
import Foundation
import Combine

class ImageLoadingOperation: Operation {
    @Published var image: UIImage?
    private var downloadRequest: DownloadRequest?
    
    enum State: String {
        case ready
        case finished
        case executing
        
        var keyPath: String {
            "is" + rawValue.capitalized
        }
    }
    
    var state: State = .ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isReady: Bool {
        super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        state == .executing
    }
    
    override var isFinished: Bool {
        state == .finished
    }
    
    override var isAsynchronous: Bool {
        true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    override func cancel() {
        super.cancel()
        downloadRequest?.cancel()
        state = .finished
    }

    let imageURL: URL
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    // MARK: -
    
    override func main() {
        guard !isCancelled else { return }
        
        downloadImage()
    }
    
    private func downloadImage() {
        downloadRequest = AF.download(imageURL).response {response in
            guard !self.isCancelled else { return }
            
            if response.error == nil, let imagePath = response.fileURL?.path {
                self.image = UIImage(contentsOfFile: imagePath)
            } else {
                self.image = nil
            }
            self.state = .finished
        }
    }
}

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
