//
//  LaunchRepository.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

protocol LaunchRepository {
    func fetchLaunches(
        from server: Bool,
        rocketID: String,
        page: Int,
        fetchOffset: Int
    ) async throws -> [Launch]
}
