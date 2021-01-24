//
//  RocketsListViewModel.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Combine
import Foundation

final class RocketsListViewModel {
    @Published var isLoading: Bool = true
    @Published var items: [RocketsListItemViewModel] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    let rocketsService: RocketsService
    
    init(rocketsService: RocketsService) {
        self.rocketsService = rocketsService
    }
    
    func fetchRockets() {
        isLoading = true
        rocketsService.fetchRocketsList()
            .sink(receiveCompletion: { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                print("error \(error)")
                // TODO: Show error
                self?.isLoading = false
            }, receiveValue: { [weak self] value in
                self?.items = value.map { RocketsListItemViewModel($0) }
                self?.isLoading = false
            })
            .store(in: &cancellable)
    }
}
