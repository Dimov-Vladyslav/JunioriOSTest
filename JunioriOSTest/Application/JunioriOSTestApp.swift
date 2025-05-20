//
//  JunioriOSTestApp.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 17.05.2025.
//

import SwiftUI
import SwiftData
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

func application(_ app: UIApplication,
                 open url: URL,
                 options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
}

@main
struct JunioriOSTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Rocket.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @State private var diContainer: AppDIContainer

    init() {
        let modelContext = sharedModelContainer.mainContext

        _diContainer = State(initialValue: AppDIContainer(
            modelContext: modelContext,
            firebaseAuthService: FirebaseAuthService()
        ))
    }

    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: diContainer.makeSplashViewModel())
        }
        .environment(\.diContainer, diContainer)
        .modelContainer(sharedModelContainer)
    }
}

// MARK: - ENVIRONMENT KEYS
struct DIContainerKey: EnvironmentKey {
    static let defaultValue: AppDIContainer = AppDIContainer(
        modelContext: nil,
        firebaseAuthService: FirebaseAuthService()
    )
}

extension EnvironmentValues {
    var diContainer: AppDIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
