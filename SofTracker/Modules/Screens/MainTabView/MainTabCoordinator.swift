//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct MainTabCoordinator: View {
    // MARK: - Properties
    
    @StateObject var viewModel: MainTabViewModel = .init()
    @State var presentSideMenu: Bool = false
    var edgeTransition: AnyTransition = .move(edge: .leading)
    
    // MARK: - Body

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                topSideMenu
                tabView
            }
            
            if presentSideMenu {
                SideMenuView(selectedSideMenuTab: $viewModel.selectedTab, presentSideMenu: $presentSideMenu)
                    .transition(edgeTransition)
                    .animation(.easeInOut, value: presentSideMenu)
            }
        }
    }
    
    // MARK: - View
    
    var tabView: some View {
        TabView(
            selection: $viewModel.selectedTab,
            content: {
                Tab1Screen().tabItem {
                    TabItem(
                        title: "Home",
                        icon: "house"
                    )
                }.tag(Tab.tab1)
                
                Tab2Screen().tabItem {
                    TabItem(
                        title: "Profile",
                        icon: "person"
                    )
                }.tag(Tab.tab2)
            }
        )
        .accentColor(.primarySof)
        .onAppear {
            withAnimation {
                UITabBar.appearance().unselectedItemTintColor = UIColor(.gray.opacity(0.5))
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    let horizontalAmount = value.translation.width
                            
                    if horizontalAmount < -50 {
                        viewModel.switchToNextTab()
                    } else if horizontalAmount > 50 {
                        viewModel.switchToPreviousTab()
                    }
                }
        )
    }
    
    var topSideMenu: some View {
        HStack {
            Button {
                withAnimation {
                    AnalyticsManager.logButtonClickEvent(buttonType: .secondary, label: "Side menu")
                    presentSideMenu = true
                }
            } label: {
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 22, height: 22)
            }
            .foregroundColor(.white)
            .padding()
            
            Spacer()
            
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
        }
        .background(Color.primarySof)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MainTabCoordinator()
}
