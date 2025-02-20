//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct Tab1Screen: View {
    var title: String?
    
    var body: some View {
        VStack {
            Text(AppStrings.Tab) + Text("1")
            WeatherScreen()
        }
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    }
}

#Preview {
    Tab1Screen()
}
