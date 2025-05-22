//
//  LaunchRepositoryImpl.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

final class LaunchRepositoryImpl: LaunchRepository {
    private let launchesAPIService: LaunchesAPIService
    private let launchCacheService: LaunchCacheService

    init(
        launchesAPIService: LaunchesAPIService,
        launchCacheService: LaunchCacheService
    ) {
        self.launchesAPIService = launchesAPIService
        self.launchCacheService = launchCacheService
    }

    func fetchLaunches(
        from server: Bool,
        rocketID: String,
        page: Int,
        fetchOffset: Int
    ) async throws -> [Launch] {
        if server {
            let launches = try await launchesAPIService.fetchLaunches(for: rocketID, page: page)

            try await launchCacheService.saveLaunches(launches)

            return launches
        } else {
            return try await launchCacheService.loadLaunches(for: rocketID, offset: fetchOffset)
        }
    }
}
