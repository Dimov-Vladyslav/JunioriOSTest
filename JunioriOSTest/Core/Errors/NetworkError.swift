//
//  NetworkError.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 20.05.2025.
//

import SwiftUI

enum NetworkError: LocalizedError {
    case unknown

    var errorDescription: LocalizedStringKey? {
        switch self {
        case .unknown:
            return LocalizedStringKey("unknownError")
        }
    }
}
