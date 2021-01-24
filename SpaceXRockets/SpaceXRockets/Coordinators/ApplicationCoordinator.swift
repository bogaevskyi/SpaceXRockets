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
    
    // Coordinators
    private var rocketsListViewCoordinator: RocketsListViewCoordinator?
    
    init(window: UIWindow, networkService: NetworkService) {
        self.window = window
        self.networkService = networkService
    }
    
    // MARK: - Coordinator
    
    func start() {
        let rocketsListView = makeRocketsListView()
        let navigationController = UINavigationController(rootViewController: rocketsListView)
        navigationController.navigationBar.prefersLargeTitles = true
        
        rocketsListViewCoordinator = RocketsListViewCoordinator(rocketsListView: rocketsListView)
        rocketsListViewCoordinator?.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // MARK: -
    
    private func makeRocketsListView() -> RocketsListView{
        let rocketsService = RocketsNetworkService(network: networkService)
        let viewModel = RocketsListViewModel(rocketsService: rocketsService)
        return RocketsListView(viewModel: viewModel)
    }
}
