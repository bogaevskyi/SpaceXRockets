//
//  ImageLoadingOperation.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 26.01.2021.
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
