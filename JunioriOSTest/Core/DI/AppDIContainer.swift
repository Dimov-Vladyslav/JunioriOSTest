//
//  AppDIContainer.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

final class AppDIContainer {
    func makeSplashViewModel() -> SplashViewModel {
        let authRepositoryImpl = AuthRepositoryImpl(firebaseAuthService: FirebaseAuthService())
        let checkAuthUseCaseImpl = CheckAuthUseCaseImpl(authRepository: authRepositoryImpl)
        let splashVM = SplashViewModel(checkAuthUseCase: checkAuthUseCaseImpl)
        return splashVM
    }
}
