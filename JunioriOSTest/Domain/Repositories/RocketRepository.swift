//
//  RocketRepository.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

protocol RocketRepository {
    func fetchRockets(from server: Bool) async throws -> [Rocket]
}
