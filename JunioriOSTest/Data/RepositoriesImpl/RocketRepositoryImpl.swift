//
//  RocketRepositoryImpl.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

final class RocketRepositoryImpl: RocketRepository {
    private let rocketAPIService: RocketAPIService
    private let rocketCacheService: RocketCacheService

    init(
        rocketAPIService: RocketAPIService,
        rocketCacheService: RocketCacheService
    ) {
        self.rocketAPIService = rocketAPIService
        self.rocketCacheService = rocketCacheService
    }

    func fetchRockets(from server: Bool) async throws -> [Rocket] {
        if server {
            let rockets = try await rocketAPIService.fetchRockets()

            try await rocketCacheService.saveRockets(rockets)

            return rockets
        } else {
            return try await rocketCacheService.loadRockets()
        }
    }
}
