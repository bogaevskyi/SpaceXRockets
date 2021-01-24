//
//  RocketsListViewCoordinator.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Foundation

protocol RocketsListViewCoordinatorDelegate: AnyObject {
    func openRocketDetailPage()
}

final class RocketsListViewCoordinator: Coordinator {
    private let rocketsListView: RocketsListView
    
    init(rocketsListView: RocketsListView) {
        self.rocketsListView = rocketsListView
    }
    
    // MARK: - Coordinator
    
    func start() {
        rocketsListView.coordinatorDelegate = self
    }
}

extension RocketsListViewCoordinator: RocketsListViewCoordinatorDelegate {
    func openRocketDetailPage() {
        // TODO: implement
    }
}
