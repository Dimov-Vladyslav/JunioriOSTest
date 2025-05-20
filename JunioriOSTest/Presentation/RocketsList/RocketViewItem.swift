//
//  RocketViewItem.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import Foundation

struct RocketViewItem {
    let id: String
    let name: String
    let firstFlight: String
    let successRate: String
    let height: String
    let diameter: String
    let mass: String

    init(rocket: Rocket) {
        self.id = rocket.id
        self.name = rocket.name
        self.firstFlight = rocket.firstFlight
        self.successRate = "\(rocket.successRate)% success"
        self.height = "\(rocket.height) m"
        self.diameter = "\(rocket.diameter) m"
        self.mass = "\(rocket.mass) kg"
    }
}
