//
//  HttpClient.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Alamofire
import Combine

class HttpClient: NetworkService {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func performRequest<T: Decodable>(_ router: RequestRouter) -> AnyPublisher<T, AFError> {
        let request = router.makeURLRequest(baseURL: baseURL)
        return AF.request(request)
            .publishDecodable(type: T.self)
            .value()
    }
}
