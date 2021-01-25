//
//  RecketDetailsViewModel.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Combine
import Foundation

enum RecketDetailsViewState {
    case loading
    case finished(info: RecketDetailsPageInfo)
    case error(description: String)
}

final class RecketDetailsViewModel: ObservableObject {
    @Published var state: RecketDetailsViewState = .loading
    
    private var cancellable = Set<AnyCancellable>()
    let rocketsService: RocketsService
    let rocketId: String
    
    init(rocketId: String, rocketsService: RocketsService) {
        self.rocketId = rocketId
        self.rocketsService = rocketsService
    }
    
    func fetchRocketInfo() {
        state = .loading
        rocketsService.fetchRocket(byId: rocketId)
            .sink(receiveCompletion: { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.state = .error(description: error.localizedDescription)
            }, receiveValue: { [weak self] value in
                self?.state = .finished(info: RecketDetailsPageInfo(value))
            })
            .store(in: &cancellable)
    }
}
