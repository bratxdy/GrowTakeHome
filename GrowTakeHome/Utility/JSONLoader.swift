//
//  JSONLoader.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import Foundation

struct JSONLoader {
    func loadJSONFile<T: Decodable>(named fileName: String, type: T.Type) throws -> T {
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return try decoder.decode(T.self, from: data)
        } else {
            let error = URLError(.fileDoesNotExist)
            throw APIError(error: error)
        }
    }
}
