//
//  ImageRepositoryImpl.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 21.05.2025.
//

import UIKit
import SwiftData

final class ImageRepositoryImpl: ImageRepository {
    private let imageService: ImageServiceProtocol
    private let imageCacheService: ImageCacheServiceProtocol

    init(
        imageService: ImageServiceProtocol,
        imageCacheService: ImageCacheServiceProtocol
    ) {
        self.imageService = imageService
        self.imageCacheService = imageCacheService
    }

    func fetchImage(from url: URL, for item: any PersistentModel) async throws -> UIImage? {
        guard let imageData = try await imageService.fetchImageData(from: url) else { return nil }
        try await imageCacheService.saveImage(data: imageData, for: item)
        return UIImage(data: imageData)
    }
}
