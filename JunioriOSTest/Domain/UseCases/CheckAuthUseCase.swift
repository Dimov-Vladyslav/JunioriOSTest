//
//  CheckAuthUseCaseImpl.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

protocol CheckAuthUseCase {
    func execute() -> Bool
}

final class CheckAuthUseCaseImpl: CheckAuthUseCase {
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func execute() -> Bool {
        authRepository.isUserAuthenticated()
    }
}
