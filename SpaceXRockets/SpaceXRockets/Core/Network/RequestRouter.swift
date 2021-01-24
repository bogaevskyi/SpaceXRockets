//
//  RequestRouter.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Alamofire

protocol RequestRouter {
    var httpMethod: HTTPMethod { get }
    var path: String { get }
}

extension RequestRouter {
    func makeURLRequest(baseURL: URL) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = httpMethod
        return request
    }
}
