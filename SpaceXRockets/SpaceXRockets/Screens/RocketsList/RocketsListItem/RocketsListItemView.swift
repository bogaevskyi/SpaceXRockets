//
//  RocketsListItemView.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import UIKit
import Combine

class RocketsListItemView: UICollectionViewCell {
    @IBOutlet private var backgroundImage: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var rateBadgeLabel: UILabel!
    
    private var cancellable = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 12
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable.removeAll()
    }
    
    func setup(with viewModel: RocketsListItemViewModel) {
        titleLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        rateBadgeLabel.text = viewModel.rateBadge
        
        if let url = viewModel.imageURL {
            backgroundImage.setImage(url: url).store(in: &cancellable)
        }
    }
}


extension UIImageView {
    func setImage(url: URL) -> AnyCancellable {
        ImageLoader.shared.getImage(url: url)
            .sink { [weak self] image in
                self?.image = image
            }
    }
}
