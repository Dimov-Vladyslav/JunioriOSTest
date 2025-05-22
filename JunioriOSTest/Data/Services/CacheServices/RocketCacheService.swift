//
//  RocketCacheService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import SwiftUI
import SwiftData

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
        let descriptor = FetchDescriptor<Rocket>(
            sortBy: [SortDescriptor(\.name, order: .forward)]
        )
        let rockets = try modelContext.fetch(descriptor)
        return rockets
    }
}
