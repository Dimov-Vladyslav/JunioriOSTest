//
//  NetworkMonitorService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import Network

protocol NetworkMonitorServiceProtocol {
    func checkNetworkConnection() -> Bool
}

final class NetworkMonitorService: NetworkMonitorServiceProtocol {
    private let monitor = NWPathMonitor()
    private var isConnected = false

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func checkNetworkConnection() -> Bool {
        return isConnected
    }
}
