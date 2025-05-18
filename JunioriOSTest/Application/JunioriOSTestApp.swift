//
//  JunioriOSTestApp.swift
//  JunioriOSTest
//
//  Created by Vladyslav on 17.05.2025.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct JunioriOSTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    private let diContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: diContainer.makeSplashViewModel())
        }
//        .modelContainer(sharedModelContainer)
    }
}
