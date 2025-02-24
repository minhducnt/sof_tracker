//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct RootCoordinator: View {
    // MARK: - Properties

    enum Root {
        case splash
        case authorization
        case userDetails
        case mainApp
    }
    
    @State private var root: Root = .splash
    
    @ObservedObject private var rootViewModel = RootViewModel()
    @ObservedObject private var authenticationManager = AuthenticationManager.shared
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            switch root {
            case .splash:
                SplashScreen()
                    .onAppear {
                        appStart()
                    }
                
            case .authorization:
                AuthorizationScreen()
                
            case .userDetails:
                UserDetailsScreen(onCompleted: {
                    rootViewModel.markUserDetailsCompleted()
                })
                
            case .mainApp:
                MainTabCoordinator()
            }
        }
       
        .onChange(of: rootViewModel.isAppStartCompleted) { _, _ in updateRoot() }
        .onChange(of: authenticationManager.isAuthenticated) { _, _ in updateRoot() }
        .onChange(of: rootViewModel.isUserDetailsFilled) { _, _ in updateRoot() }
    }
    
    // MARK: - Functions

    private func appStart() {
        Task { @MainActor in
            do {
                try await rootViewModel.start()
            }
            catch {
                ErrorHandler.logError(message: "Error while starting app", error: error)
            }
        }
    }
    
    private func updateRoot() {
        if !rootViewModel.isAppStartCompleted {
            root = .splash
        }
        else if !authenticationManager.isAuthenticated {
            root = .authorization
            rootViewModel.setInitialScreenVisitedStatus()
        }
        else if !rootViewModel.isUserDetailsFilled {
            root = .userDetails
        }
        else {
            root = .mainApp
        }
    }
}

#Preview {
    RootCoordinator()
}
