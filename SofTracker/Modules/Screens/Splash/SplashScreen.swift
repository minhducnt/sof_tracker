//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct SplashScreen: View {
    // MARK: - Properties

    @State private var isVisible: Bool = false
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.white

            // MARK: - Logo

            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(isVisible ? 1.0 : 0.5)
                    .opacity(isVisible ? 1 : 0)
                    .onAppear {
                        AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                            isVisible = true
                        }
                    }
            }
            .padding()

            // MARK: Background Images

            Image(.sofSplashBg1)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .offset(x: isVisible ? 0 : screenWidth, y: isVisible ? 0 : screenHeight)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.6)) {
                        isVisible = true
                    }
                }

            Image(.sofSplashBg2)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .offset(x: isVisible ? 0 : -screenWidth, y: isVisible ? 0 : screenHeight)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.6)) {
                        isVisible = true
                    }
                }
        }
        .ignoresSafeArea()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SplashScreen()
}
