//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct SettingsScreen: View {
    // MARK: - Attributes

    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: SettingsViewModel = .init()
    
    @State var presentEditInfoScreen = false
    @State private var selectedMode = Preferences.appearanceMode

    // MARK: - Views
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                // MARK: - Header

                Header(
                    text: AppStrings.Settings,
                    hasBackButton: true,
                    onBackArrowClick: {
                        dismiss()
                    }
                )
                
                // MARK: - User Details
         
                userDetailsView
                
                // MARK: - Update Btn

                updateButtonView
                
                // MARK: - Appearance Selection

                AppearanceSelectionView(selectedMode: $selectedMode)
                    .padding(.top, 20)
                
                // MARK: - Bottom Btn

                bottomButtons
                
            }.padding()
            
            // MARK: - Bottom Sheet

            if viewModel.currentBottomSheetType != nil {
                bottomSheet
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.setUp()
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    }
    
    // MARK: - User Detail View
    
    var userDetailsView: some View {
        VStack(spacing: 20) {
            TitleValueView(title: AppStrings.Name, value: viewModel.userName)
            
            TitleValueView(title: AppStrings.Email, value: viewModel.userEmail)
            
            TitleValueView(title: AppStrings.Gender, value: getLocalString(viewModel.gender))
            
            TitleValueView(title: AppStrings.DateOfBirth, value: viewModel.dob)
            
            TitleValueView(title: AppStrings.Country, value: getLocalString(viewModel.country))
            
            TitleValueView(title: AppStrings.Language, value: userLanguage)
        }
    }
    
    // MARK: - Update Btn View
    
    var updateButtonView: some View {
        TextButton(
            onClick: {
                AnalyticsManager.logButtonClickEvent(buttonType: .primary, label: "Update")
                presentEditInfoScreen = true
            },
            text: AppStrings.Update
        )
        .fullScreenCover(
            isPresented: $presentEditInfoScreen,
            onDismiss: {
                viewModel.setUp()
            },
            content: {
                EditUserDetailsScreen()
            }
        )
    }
    
    // MARK: - Bottom Btn View
    
    var bottomButtons: some View {
        VStack {
            Spacer()
            HStack {
                TextButton(
                    onClick: {
                        AnalyticsManager.logButtonClickEvent(buttonType: .secondary, label: "Logout")
                        viewModel.currentBottomSheetType = .logout
                    },
                    text: AppStrings.Logout,
                    style: .outline,
                    color: .orange
                )
                TextButton(
                    onClick: {
                        AnalyticsManager.logButtonClickEvent(buttonType: .secondary, label: "Delete Account")
                        viewModel.currentBottomSheetType = .delete
                    },
                    text: AppStrings.DeleteAccount,
                    style: .outline,
                    color: .red
                )
            }
        }
    }
    
    // MARK: - Bottom Sheet View

    var bottomSheet: some View {
        @State var isOpen = Binding<Bool>(
            get: { viewModel.currentBottomSheetType != nil },
            set: { if !$0 { viewModel.currentBottomSheetType = nil } }
        )
        
        return CustomBottomSheetView(
            isOpen: isOpen,
            maxHeight: viewModel.currentBottomSheetType!.sheetSize,
            content: {
                if viewModel.currentBottomSheetType != nil {
                    ConfirmationSheet(
                        isConfirmationGiven: $viewModel.isConfirmationGiven,
                        isOpen: isOpen,
                        title: viewModel.currentBottomSheetType!.title,
                        subTitle: viewModel.currentBottomSheetType!.subTitle
                    )
                }
            }
        )
    }
}

struct TitleValueView: View {
    let title: LocalizedStringKey
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
        .foregroundColor(.text)
    }
}

struct AppearanceSelectionView: View {
    @Binding var selectedMode: AppearanceMode
    
    var body: some View {
        HStack {
            Text(AppStrings.Appearance)
            Spacer()
            Picker(AppStrings.Appearance, selection: $selectedMode) {
                Text(AppStrings.Light).tag(AppearanceMode.light)
                Text(AppStrings.Dark).tag(AppearanceMode.dark)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedMode) { _, newValue in
                Preferences.appearanceMode = newValue
            }
        }
        .foregroundColor(.text)
    }
}

#Preview {
    SettingsScreen()
}
