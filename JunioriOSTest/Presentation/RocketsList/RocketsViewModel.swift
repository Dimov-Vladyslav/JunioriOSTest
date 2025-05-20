//
//  RocketsViewModel.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import Combine

enum RocketsStatus {
    case loading, fetched([Rocket]), error(String)
}

final class RocketsViewModel {
    private let rocketUseCase: RocketUseCase

    @Published private(set) var rocketsStatus: RocketsStatus = .loading

    init(rocketUseCase: RocketUseCase) {
        self.rocketUseCase = rocketUseCase
    }

    @MainActor
    func fetchRockets() async {
        do {
            let rockets = try await rocketUseCase.execute()

            rocketsStatus = .fetched(rockets)
        } catch {
            rocketsStatus = .error(error.localizedDescription)
        }
    }
}
