//
//  RocketsListViewCoordinator.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Foundation
import SwiftUI

protocol RocketsListViewCoordinatorDelegate: AnyObject {
    func openRocketDetailPage(rocketId: String, rocketName: String)
}

final class RocketsListViewCoordinator: Coordinator {
    private let rocketsListView: RocketsListView
    private let rocketsService: RocketsService
    
    init(rocketsListView: RocketsListView, rocketsService: RocketsService) {
        self.rocketsListView = rocketsListView
        self.rocketsService = rocketsService
    }
    
    // MARK: - Coordinator
    
    func start() {
        rocketsListView.coordinatorDelegate = self
    }
}

extension RocketsListViewCoordinator: RocketsListViewCoordinatorDelegate {
    func openRocketDetailPage(rocketId: String, rocketName: String) {
        let vm = RecketDetailsViewModel(rocketId: rocketId, rocketsService: rocketsService)
        let detailsView = RecketDetailsView(viewModel: vm)        
        let vc = UIHostingController(rootView: detailsView)
        vc.title = rocketName
        rocketsListView.navigationController?.pushViewController(vc, animated: true)
    }
}
