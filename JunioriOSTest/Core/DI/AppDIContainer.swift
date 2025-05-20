//
//  AppDIContainer.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

import SwiftData

final class AppDIContainer {
    let modelContext: ModelContext?
    let firebaseAuthService: FirebaseAuthService

    init(
        modelContext: ModelContext?,
        firebaseAuthService: FirebaseAuthService
    ) {
        self.modelContext = modelContext
        self.firebaseAuthService = firebaseAuthService
    }

    func makeSplashViewModel() -> SplashViewModel {
        let authRepositoryImpl = AuthRepositoryImpl(firebaseAuthService: firebaseAuthService)
        let checkAuthUseCaseImpl = CheckAuthUseCaseImpl(authRepository: authRepositoryImpl)
        let splashVM = SplashViewModel(checkAuthUseCase: checkAuthUseCaseImpl)
        return splashVM
    }

    func makeLoginViewModel() -> LoginViewModel {
        let loginRepositoryImpl = LoginRepositoryImpl(firebaseAuthService: firebaseAuthService)
        let loginUseCaseImpl = LoginUseCaseImpl(loginRepository: loginRepositoryImpl)
        let loginVM = LoginViewModel(loginUseCase: loginUseCaseImpl)
        return loginVM
    }

    func makeRocketsViewModel() -> RocketsViewModel {
        let rocketRepository = RocketRepositoryImpl(
            rocketAPIService: RocketAPIService(),
            rocketCacheService: RocketCacheService(modelContext: modelContext)
        )
        let rocketUseCase = RocketUserCaseImpl(
            rocketRepository: rocketRepository,
            networkMonitorService: NetworkMonitorService()
        )
        let rocketVM = RocketsViewModel(rocketUseCase: rocketUseCase)
        return rocketVM
    }
}
