//
//  RocketCacheService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 19.05.2025.
//

import SwiftData
import SwiftUI

protocol RocketCacheServiceProtocol {
    func saveRockets(_ rockets: [Rocket]) async throws
    func loadRockets() async throws -> [Rocket]
}

final class RocketCacheService: RocketCacheServiceProtocol {
    private let modelContext: ModelContext?

    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }

    // MARK: - SAVE
    @MainActor
    func saveRockets(_ rockets: [Rocket]) async throws {
        guard let modelContext else { return }

        rockets.forEach { modelContext.insert($0) }

        try modelContext.save()
    }

    // MARK: - LOAD
    @MainActor
    func loadRockets() async throws -> [Rocket] {
        guard let modelContext else { return [] }
        let descriptor = FetchDescriptor<Rocket>(sortBy: [.init(\.name)])
        return try modelContext.fetch(descriptor)
    }
}
