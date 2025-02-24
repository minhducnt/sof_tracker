//
//  Created by TMA on 02/20/25.
//
import Foundation
import SwiftUI

enum AppearanceMode: String {
    case light, dark
}

enum Preferences {
    static var appearanceMode: AppearanceMode {
        get {
            let storedValue = UserPreferences.shared.selectedAppearance
            return AppearanceMode(rawValue: storedValue) ?? .light
        }
        set {
            UserPreferences.shared.selectedAppearance = newValue.rawValue
            applyAppearance(newValue)
        }
    }

    static func applyAppearance(_ mode: AppearanceMode) {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                for window in windowScene.windows {
                    switch mode {
                    case .light:
                        window.overrideUserInterfaceStyle = .light
                    case .dark:
                        window.overrideUserInterfaceStyle = .dark
                    }
                }
            }
        }
    }
}
