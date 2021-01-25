//
//  RocketsListItemView.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import UIKit

class RocketsListItemView: UICollectionViewCell {
    @IBOutlet private var backgroundImage: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var rateBadgeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 12
    }
    
    func setup(with viewModel: RocketsListItemViewModel) {
        // TODO: set image from URL
        backgroundImage.image = UIImage(named: "rocket")
        titleLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        rateBadgeLabel.text = viewModel.rateBadge
    }
}
