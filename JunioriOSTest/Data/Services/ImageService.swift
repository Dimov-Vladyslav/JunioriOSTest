//
//  ImageService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 21.05.2025.
//

import Foundation

protocol ImageServiceProtocol {
    func fetchImageData(from url: URL) async throws -> Data?
}

final class ImageService: ImageServiceProtocol {
    func fetchImageData(from url: URL) async throws -> Data? {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return nil
        }

        return data
    }
}
