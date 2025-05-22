//
//  LoginView.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 18.05.2025.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel: LoginViewModel
    let onSuccessLogin: () -> Void

    @State private var isShowError = false
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            Text(LocalizedStringKey("signIn"))
                .font(.largeTitle)

            Button {
                Task {
                    await viewModel.login()
                }
            } label: {
                Text(LocalizedStringKey("signInWithGoogle"))
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.status == .loading)

            if viewModel.status == .loading {
                ProgressView()
            }
        }
        .bold()
        .alert(
            LocalizedStringKey("authError"),
            isPresented: $isShowError,
            actions: {},
            message: {
                Text(errorMessage)
            }
        )
        .onChange(of: viewModel.status) { _, newValue in
            switch newValue {
            case .authorized:
                onSuccessLogin()
            case .error(let description):
                errorMessage = description
                isShowError = true
            default:
                return
            }
        }
    }
}
