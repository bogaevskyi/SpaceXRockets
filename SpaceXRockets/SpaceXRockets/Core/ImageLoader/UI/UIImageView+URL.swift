//
//  UIImageView+URL.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 26.01.2021.
//

import UIKit
import Combine

extension UIImageView {
    func setImage(url: URL) -> AnyCancellable {
        ImageLoader.shared.getImage(url: url)
            .sink { [weak self] image in
                self?.image = image
            }
    }
}
