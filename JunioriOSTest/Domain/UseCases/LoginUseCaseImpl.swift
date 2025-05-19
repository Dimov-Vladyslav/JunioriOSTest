//
//  LoginUseCaseImpl.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

final class LoginUseCaseImpl: LoginUseCase {
    private let loginRepository: LoginRepository

    init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
    }

    func execute() async throws -> Bool {
        try await loginRepository.signIn()

        return true
    }
}
