//
//  LoginRepositoryImpl.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

final class LoginRepositoryImpl: LoginRepository {
    private let firebaseAuthService: FirebaseAuthService

    init(firebaseAuthService: FirebaseAuthService) {
        self.firebaseAuthService = firebaseAuthService
    }

    func signIn() async throws {
        try await firebaseAuthService.googleSignIn()
    }
}
