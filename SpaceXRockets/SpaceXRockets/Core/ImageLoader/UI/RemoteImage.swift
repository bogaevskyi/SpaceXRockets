//
//  RemoteImage.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 26.01.2021.
//

import Foundation
import SwiftUI
import Combine

struct RemoteImage<Placeholder>: View where Placeholder: View {
    private class Loader: ObservableObject {
        @Published var image: UIImage?
        private var isLoading = false
        private var cancellable: AnyCancellable?
        private let url: URL
        
        init(url: URL) {
            self.url = url
        }
        
        deinit {
            cancel()
        }
        
        func load() {
            guard !isLoading else { return }
            isLoading = true
            
            cancellable = ImageLoader.shared.getImage(url: url)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] image in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.isLoading = false
                    strongSelf.image = image
                }
        }
        
        func cancel() {
            cancellable?.cancel()
        }
    }
    
    @StateObject private var loader: Loader
    private let placeholder: Placeholder
    private let image: (UIImage) -> AnyView
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> AnyView)
    {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.placeholder = placeholder()
        self.image = image
    }
    
    var body: some View {
        content.onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}
