//
//  RocketUseCase.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

protocol RocketUseCase {
    func execute() async throws -> [Rocket]
}

final class RocketUserCaseImpl: RocketUseCase {
    private let rocketRepository: RocketRepository
    private let networkMonitorService: NetworkMonitorService

    init(
        rocketRepository: RocketRepository,
        networkMonitorService: NetworkMonitorService
    ) {
        self.rocketRepository = rocketRepository
        self.networkMonitorService = networkMonitorService
    }

    func execute() async throws -> [Rocket] {
        let status = networkMonitorService.checkNetworkConnection()
        return try await rocketRepository.fetchRockets(from: status)
    }
}
