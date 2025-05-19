//
//  AppDIContainer.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

final class AppDIContainer {
    let firebaseAuthService: FirebaseAuthService

    init(firebaseAuthService: FirebaseAuthService) {
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
}
