//
//  LaunchesAPIService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import Foundation

protocol LaunchesAPIServiceProtocol {
//    func fetchLaunches() async throws -> [Launch]
    func fetchLaunches(for rocketID: String, page: Int) async throws -> [Launch]
}

final class LaunchesAPIService: LaunchesAPIServiceProtocol {
//    func fetchLaunches() async throws -> [Launch] {
//        guard let url = URL(string: "https://api.spacexdata.com/v5/launches") else { return [] }
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
//        guard let launchDTOs = try? JSONDecoder().decode([LaunchDTO].self, from: data) else {
//            return []
//        }
//
//        return launchDTOs.map { $0.toDomain() }
//    }

    // MARK: Necessary fields, pagination, filter
    func fetchLaunches(for rocketID: String, page: Int) async throws -> [Launch] {
        guard let url = URL(string: "https://api.spacexdata.com/v5/launches/query") else { return [] }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "query": ["rocket": rocketID],
            "options": [
                "select": [
                    "id": 1,
                    "rocket": 1,
                    "name": 1,
                    "details": 1,
                    "date_utc": 1,
                    "links.patch.large": 1,
                    "links.article": 1,
                    "links.wikipedia": 1,
                    "success": 1
                ],
                "limit": 5,
                "page": page,
                "sort": ["date_utc": "desc"]
            ]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.unknown
        }

        struct ResponseWrapper: Decodable {
            let docs: [LaunchDTO]
        }

        let decoded = try JSONDecoder().decode(ResponseWrapper.self, from: data)

        return decoded.docs.map { $0.toDomain() }
    }
}
