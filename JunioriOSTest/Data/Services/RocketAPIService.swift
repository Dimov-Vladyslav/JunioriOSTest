//
//  RocketAPIService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 19.05.2025.
//

import SwiftUI

protocol RocketAPIServiceProtocol {
    func fetchRockets() async throws -> [Rocket]
}

enum NetworkError: LocalizedError {
    case unknown

    var errorDescription: LocalizedStringKey? {
        switch self {
        case .unknown:
            return LocalizedStringKey("unknownError")
        }
    }
}

final class RocketAPIService: RocketAPIServiceProtocol {
    func fetchRockets() async throws -> [Rocket] {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return [] }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.unknown
        }

        guard let rocketDTOs = try? JSONDecoder().decode([RocketDTO].self, from: data) else {
            return []
        }

        return rocketDTOs.map { $0.toDomain() }
    }
}
