//
//  ImageUseCase.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 21.05.2025.
//

import UIKit

protocol ImageUseCase {
    func execute(_ launch: Launch) async throws -> UIImage?
}

final class ImageUseCaseImpl: ImageUseCase {
    private let imageRepository: ImageRepository
    private let imageCacheService: ImageCacheServiceProtocol

    init(
        imageRepository: ImageRepository,
        imageCacheService: ImageCacheServiceProtocol
    ) {
        self.imageRepository = imageRepository
        self.imageCacheService = imageCacheService
    }

    func execute(_ launch: Launch) async throws -> UIImage? {
        if let imageData = try await imageCacheService.loadImage(for: launch.id), let image = UIImage(data: imageData) {
            return image
        } else {
            guard let url = launch.imageURL else { return nil }
            return try await imageRepository.fetchImage(from: url, for: launch)
        }
    }
}
