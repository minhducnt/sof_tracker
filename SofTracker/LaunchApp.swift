//
// Created by TMA on 02/20/25.
//
import SwiftUI
import FirebaseCore

@main
struct LaunchApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        Preferences.applyAppearance(Preferences.appearanceMode)
    }

    var body: some Scene {
        WindowGroup {
            RootCoordinator()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - SETUP FIREBASE

    func application(_ application: UIApplication, didFinishLaunchingWithOTMA_Assignmentptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
