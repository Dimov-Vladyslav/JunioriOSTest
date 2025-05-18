//
//  FirebaseAuthService.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

import FirebaseAuth

final class FirebaseAuthService {
    var currentUser: User? {
        return Auth.auth().currentUser
    }
}
