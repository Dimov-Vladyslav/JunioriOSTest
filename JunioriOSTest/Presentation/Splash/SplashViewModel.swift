//
//  SplashViewModel.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

import SwiftUI

enum ScreenType {
    case login, rockets
}

@Observable final class SplashViewModel {
    private let checkAuthUseCase: CheckAuthUseCase
    var screenType: ScreenType?

    init(checkAuthUseCase: CheckAuthUseCase) {
        self.checkAuthUseCase = checkAuthUseCase
    }

    func checkAuth() {
        let isAuthorized = checkAuthUseCase.execute()
        screenType = isAuthorized ? .rockets : .login
    }
}
