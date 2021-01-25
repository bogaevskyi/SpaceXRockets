//
//  ActivityIndicator.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 25.01.2021.
//

import UIKit
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    let isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    init(isAnimating: Bool, style: UIActivityIndicatorView.Style = .large) {
        self.isAnimating = isAnimating
        self.style = style
    }

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
