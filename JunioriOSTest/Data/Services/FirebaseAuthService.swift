//
//  FirebaseAuthService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import SwiftUI

enum AuthError: LocalizedError {
    case badIdToken

//    var errorDescription: String? {
    var errorDescription: LocalizedStringKey? {
        switch self {
        case .badIdToken:
//            return "No ID token."
            return LocalizedStringKey("badIDToken")
        }
    }
}

final class FirebaseAuthService {
    var currentUser: User? {
        return Auth.auth().currentUser
    }
}

// MARK: - SIGN IN WITH GOOGLE
extension FirebaseAuthService {
    @MainActor
    func googleSignIn() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

        let user = result.user
        let fullName = user.profile?.name

        guard let idToken = user.idToken?.tokenString else {
            throw AuthError.badIdToken
        }

        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )

        try await signInWithCredential(credential, fullName: fullName)
    }
}

// MARK: - SIGN IN WITH CREDENTIALS
extension FirebaseAuthService {
    private func signInWithCredential(
        _ credential: AuthCredential,
        fullName: String?
    ) async throws {
        let result = try await Auth.auth().signIn(with: credential)

        let user = result.user

        guard user.displayName == nil && fullName != nil else {
            return
        }

        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = fullName
        try await changeRequest.commitChanges()
    }
}
