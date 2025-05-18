//
//  SplashView.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

import SwiftUI

struct SplashView: View {
    @State var viewModel: SplashViewModel

    var body: some View {
        Group {
            switch viewModel.screenType {
            case .login:
                Text("Login")
            case .rockets:
                Text("Rockets")
            default:
                EmptyView()
            }
        }
        .onAppear(perform: viewModel.checkAuth)
    }
}

#Preview {
    let diContainer = AppDIContainer()

    SplashView(viewModel: diContainer.makeSplashViewModel())
}
