//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct ProfileScreen: View {
    // MARK: - Properties

    @State private var userName: String = ""
    @State private var userEmail: String = ""

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                UserInfoView(
                    name: $userName,
                    email: $userEmail
                )

                Spacer()
            }.padding(.horizontal, 25)
        }
        .onAppear {
            updateUserInfo()
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    }

    // MARK: - Functions

    func updateUserInfo() {
        userName = UserPreferences.shared.getUser()?.name ?? ""
        userEmail = UserPreferences.shared.getUser()?.email ?? ""
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ProfileScreen()
}
