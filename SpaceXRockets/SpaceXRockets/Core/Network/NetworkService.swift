//
//  NetworkService.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Alamofire
import Combine

protocol NetworkService {
    func performRequest<T: Decodable>(_ router: RequestRouter) -> AnyPublisher<T, AFError>
}
