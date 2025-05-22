//
//  ImageRepository.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 21.05.2025.
//

import UIKit
import SwiftData

protocol ImageRepository {
    func fetchImage(from url: URL, for item: any PersistentModel) async throws -> UIImage?
}
