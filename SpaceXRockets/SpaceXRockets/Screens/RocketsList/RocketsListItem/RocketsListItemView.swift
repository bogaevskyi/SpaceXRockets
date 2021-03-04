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
        
        backgroundImage.setImage(url: viewModel.imageURL)
            .store(in: &cancellable)
    }
}
