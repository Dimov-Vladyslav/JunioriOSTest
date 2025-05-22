//
//  LaunchCacheService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import SwiftUI
import SwiftData

protocol LaunchCacheServiceProtocol {
    func saveLaunches(_ launches: [Launch]) async throws
    func loadLaunches(for rocket: String, offset: Int) async throws -> [Launch]
}

final class LaunchCacheService: LaunchCacheServiceProtocol {
    private let modelContext: ModelContext?

    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }

    // MARK: - SAVE
    @MainActor
    func saveLaunches(_ launches: [Launch]) async throws {
        guard let modelContext else { return }
        launches.forEach { modelContext.insert($0) }
        try modelContext.save()
    }

    // MARK: - LOAD
    @MainActor
    func loadLaunches(for rocket: String, offset: Int) async throws -> [Launch] {
        guard let modelContext else { return [] }
        var descriptor = FetchDescriptor<Launch>(
            predicate: #Predicate { $0.rocket == rocket },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        descriptor.fetchLimit = 5
        descriptor.fetchOffset = offset
        let launches = try modelContext.fetch(descriptor)
        return launches
    }
}
