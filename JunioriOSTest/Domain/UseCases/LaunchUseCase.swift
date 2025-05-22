//
//  LaunchUseCase.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

protocol LaunchUseCase {
    func execute(
        for rocketID: String,
        page: Int,
        fetchOffset: Int
    ) async throws -> [Launch]
}

final class LaunchUseCaseImpl: LaunchUseCase {
    private let launchRepository: LaunchRepository
    private let networkMonitorService: NetworkMonitorServiceProtocol

    init(
        launchRepository: LaunchRepository,
        networkMonitorService: NetworkMonitorServiceProtocol
    ) {
        self.launchRepository = launchRepository
        self.networkMonitorService = networkMonitorService
    }

    func execute(
        for rocketID: String,
        page: Int,
        fetchOffset: Int
    ) async throws -> [Launch] {
        let status = networkMonitorService.checkNetworkConnection()
        return try await launchRepository.fetchLaunches(
            from: status,
            rocketID: rocketID,
            page: page,
            fetchOffset: fetchOffset
        )
    }
}
