//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct Tab1Screen: View {
    // MARK: - Properties

    var title: String?
    var screenHeight: CGFloat = UIScreen.main.bounds.height

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .top) {
            // MARK: - Background

            Color.primarySof
            
            ZStack {
                VStack {
                    GeometryReader { geometry in
                        ZStack {
                            Image(.vectorCurved1)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: .infinity,
                                       height: geometry.size.height)
                            
                            Image(.vectorCurved3)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: .infinity,
                                       height: geometry.size.height)
                        }
                    }
                    .frame(height: screenHeight / 6)
                    .clipped()
                    .offset(y: 32)
                    
                    WeatherScreen()
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 32,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 32
                            )
                        )
                }
            }
        }
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Tab1Screen()
}
