//
//  LoginViewModel.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

import SwiftUI

enum LoginStatus: Equatable {
    case loading, authorized, error(String)
}

@Observable final class LoginViewModel {
    private let loginUseCase: LoginUseCase
    var status: LoginStatus?

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    @MainActor
    func login() async {
        do {
            status = .loading

            let result = try await loginUseCase.execute()

            if result {
                status = .authorized
            }
        } catch {
            status = .error(error.localizedDescription)
        }
    }
}
