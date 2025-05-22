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

final class RocketAPIService: RocketAPIServiceProtocol {
//    func fetchRockets() async throws -> [Rocket] {
//        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return [] }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw NetworkError.unknown
//        }
//
//        guard let rocketDTOs = try? JSONDecoder().decode([RocketDTO].self, from: data) else {
//            return []
//        }
//
//        return rocketDTOs.map { $0.toDomain() }
//    }

    // MARK: - Only necessary fields
    func fetchRockets() async throws -> [Rocket] {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets/query") else { return [] }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "query": [:],
            "options": [
                "select": [
                    "id": 1,
                    "name": 1,
                    "first_flight": 1,
                    "success_rate_pct": 1,
                    "height.meters": 1,
                    "diameter.meters": 1,
                    "mass.kg": 1
                ]
            ]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.unknown
        }

        struct ResponseWrapper: Decodable {
            let docs: [RocketDTO]
        }

        let decoded = try JSONDecoder().decode(ResponseWrapper.self, from: data)
        return decoded.docs.map { $0.toDomain() }
    }
}
