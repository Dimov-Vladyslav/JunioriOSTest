//
//  ImageCacheService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 21.05.2025.
//

import SwiftData
import SwiftUI

protocol ImageCacheServiceProtocol {
    func saveImage(data: Data, for item: any PersistentModel) async throws
    func loadImage(for launchID: String) async throws -> Data?
}

final class ImageCacheService: ImageCacheServiceProtocol {
    private let modelContext: ModelContext?

    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }

    @MainActor
    func saveImage(data: Data, for item: any PersistentModel) async throws {
        guard let modelContext else { return }
        guard let launch = item as? Launch else { return }
        let launchImage = LaunchImage(launchID: launch.id, imageData: data)
        modelContext.insert(launchImage)
        try modelContext.save()
    }

    @MainActor
    func loadImage(for launchID: String) async throws -> Data? {
        guard let modelContext else { return nil }
        let descriptor = FetchDescriptor<LaunchImage>(
            predicate: #Predicate { $0.launchID == launchID }
        )
        let launchImages = try modelContext.fetch(descriptor)
        return launchImages.first?.imageData
    }
}
