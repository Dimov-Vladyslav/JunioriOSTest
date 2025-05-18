//
//  AuthRepositoryImpl.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

final class AuthRepositoryImpl: AuthRepository {
    private let firebaseAuthService: FirebaseAuthService

    init(firebaseAuthService: FirebaseAuthService) {
        self.firebaseAuthService = firebaseAuthService
    }

    func isUserAuthenticated() -> Bool {
        firebaseAuthService.currentUser != nil
    }
}
