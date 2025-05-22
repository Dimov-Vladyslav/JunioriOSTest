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
    let networkMonitorService: NetworkMonitorService

    init(
        modelContext: ModelContext?,
        firebaseAuthService: FirebaseAuthService,
        networkMonitorService: NetworkMonitorService
    ) {
        self.modelContext = modelContext
        self.firebaseAuthService = firebaseAuthService
        self.networkMonitorService = networkMonitorService
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
            networkMonitorService: networkMonitorService
        )
        let rocketVM = RocketsViewModel(rocketUseCase: rocketUseCase)
        return rocketVM
    }

    func makeLaunchesViewModel(for rocket: Rocket) -> LaunchesListViewModel {
        let imageCacheService = ImageCacheService(modelContext: modelContext)
        let launchRepository = LaunchRepositoryImpl(
            launchesAPIService: LaunchesAPIService(),
            launchCacheService: LaunchCacheService(modelContext: modelContext)
        )
        let launchUseCase = LaunchUseCaseImpl(
            launchRepository: launchRepository,
            networkMonitorService: networkMonitorService
        )
        let imageRepository = ImageRepositoryImpl(
            imageService: ImageService(),
            imageCacheService: imageCacheService
        )
        let imageUseCase = ImageUseCaseImpl(
            imageRepository: imageRepository,
            imageCacheService: imageCacheService
        )
        let launchesVM = LaunchesListViewModel(
            rocket: rocket,
            launchUseCase: launchUseCase,
            imageUseCase: imageUseCase
        )
        return launchesVM
    }
}
