//
//  Item.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 17.05.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
