//
//  RocketDTO.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 19.05.2025.
//

import Foundation

struct MeasurementDTO: Decodable {
    let meters: Float
}

struct MassDTO: Decodable {
    let massKg: Int

    enum CodingKeys: String, CodingKey {
        case massKg = "kg"
    }
}

struct RocketDTO: Decodable {
    let id: String
    let name: String
    let firstFlight: String
    let successRate: Int
    let height: MeasurementDTO
    let diameter: MeasurementDTO
    let mass: MassDTO

    enum CodingKeys: String, CodingKey {
        case id, name
        case firstFlight = "first_flight"
        case successRate = "success_rate_pct"
        case height, diameter, mass
    }

    func toDomain() -> Rocket {
        Rocket(
            id: id,
            name: name,
            firstFlight: firstFlight,
            successRate: successRate,
            height: height.meters,
            diameter: diameter.meters,
            mass: mass.massKg
        )
    }
}
