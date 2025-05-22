//
//  LaunchDTO.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import Foundation

struct ImageSizeDTO: Decodable {
    let large: String?
}

struct LinksDTO: Decodable {
    let patch: ImageSizeDTO
    let article: String?
    let wikipedia: String?
}

struct LaunchDTO: Decodable {
    let id: String
    let rocket: String
    let name: String
    let details: String?
    let date: String
    let links: LinksDTO?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case id, rocket, name, details
        case date = "date_utc"
        case links, success
    }

    func toDomain() -> Launch {
        Launch(
            id: id,
            rocket: rocket,
            name: name,
            details: details,
            date: date,
            imageURL: links?.patch.large.flatMap(URL.init),
            success: success,
            articleURL: links?.article.flatMap(URL.init),
            wikiURL: links?.wikipedia.flatMap(URL.init)
        )
    }
}
