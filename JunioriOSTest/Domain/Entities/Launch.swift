//
//  Launch.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import SwiftData
import Foundation

@Model
final class Launch: @unchecked Sendable {
    @Attribute(.unique) private(set) var id: String
    private(set) var rocket: String
    private(set) var name: String
    private(set) var details: String?
    private(set) var date: String
    private(set) var imageURL: URL?
    private(set) var success: Bool?
    private(set) var articleURL: URL?
    private(set) var wikiURL: URL?

    init(
        id: String,
        rocket: String,
        name: String,
        details: String?,
        date: String,
        imageURL: URL?,
        success: Bool?,
        articleURL: URL?,
        wikiURL: URL?
    ) {
        self.id = id
        self.rocket = rocket
        self.name = name
        self.details = details
        self.date = date
        self.imageURL = imageURL
        self.success = success
        self.articleURL = articleURL
        self.wikiURL = wikiURL
    }
}
