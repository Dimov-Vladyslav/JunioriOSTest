//
//  SplashView.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.diContainer) private var diContainer
    @State var viewModel: SplashViewModel

    var body: some View {
        Group {
            switch viewModel.screenType {
            case .login:
                LoginView(viewModel: diContainer.makeLoginViewModel()) {
                    viewModel.checkAuth()
                }
            case .rockets:
                RocketsViewControllerWrapper(viewModel: diContainer.makeRocketsViewModel())
            default:
                ProgressView()
            }
        }
        .onAppear(perform: viewModel.checkAuth)
    }
}

#Preview {
    let diContainer = AppDIContainer(
        modelContext: nil,
        firebaseAuthService: FirebaseAuthService()
    )

    SplashView(viewModel: diContainer.makeSplashViewModel())
}
