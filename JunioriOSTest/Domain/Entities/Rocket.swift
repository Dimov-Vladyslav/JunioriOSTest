//
//  Rocket.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 19.05.2025.
//

import SwiftData
import Foundation

@Model
final class Rocket: @unchecked Sendable {
    @Attribute(.unique) private(set) var id: String
    private(set) var name: String
    private(set) var firstFlight: String
    private(set) var successRate: Int
    private(set) var height: Float
    private(set) var diameter: Float
    private(set) var mass: Int

    init(
        id: String,
        name: String,
        firstFlight: String,
        successRate: Int,
        height: Float,
        diameter: Float,
        mass: Int
    ) {
        self.id = id
        self.name = name
        self.firstFlight = firstFlight
        self.successRate = successRate
        self.height = height
        self.diameter = diameter
        self.mass = mass
    }
}
