//
//  ApplicationCoordinator.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private let networkService: NetworkService
    private let rocketsService: RocketsNetworkService
    
    // Coordinators
    private var rocketsListViewCoordinator: RocketsListViewCoordinator?
    
    init(window: UIWindow, networkService: NetworkService) {
        self.window = window
        self.networkService = networkService
        self.rocketsService = RocketsNetworkService(network: networkService)
    }
    
    // MARK: - Coordinator
    
    func start() {
        let rocketsListView = makeRocketsListView()
        let navigationController = UINavigationController(rootViewController: rocketsListView)
        
        rocketsListViewCoordinator = RocketsListViewCoordinator(
            rocketsListView: rocketsListView,
            rocketsService: rocketsService)
        
        rocketsListViewCoordinator?.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // MARK: -
    
    private func makeRocketsListView() -> RocketsListView{
        let viewModel = RocketsListViewModel(rocketsService: rocketsService)
        return RocketsListView(viewModel: viewModel)
    }
}
