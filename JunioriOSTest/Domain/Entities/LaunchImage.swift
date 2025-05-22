//
//  LaunchImage.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 22.05.2025.
//

import SwiftData
import Foundation

@Model
final class LaunchImage {
    @Attribute(.unique) private(set) var launchID: String
    private(set) var imageData: Data

    init(launchID: String, imageData: Data) {
        self.launchID = launchID
        self.imageData = imageData
    }
}
