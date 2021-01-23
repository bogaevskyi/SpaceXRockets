//
//  JSONUtils.swift
//  SpaceXRocketsTests
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

import Foundation

enum JSONUtilsError: Error {
    case fileNotExist(fileName: String)
}

final class JSONUtils {
    static func model<T: Decodable>(fromFile fileName: String) throws -> T {
        let bundle = Bundle(for: JSONUtils.self)
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw JSONUtilsError.fileNotExist(fileName: fileName)
        }
        let jsonData = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: jsonData)
    }
}
