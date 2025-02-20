//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct WeatherScreen: View {
    @State var isInfoScreenPresented = false
    @StateObject var viewModel: WeatherViewModel = .init()
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    if !viewModel.isDataLoading {
                        ForEach(viewModel.weatherData, id: \.self) { data in
                            CardView(
                                title: getLocalString(data.name),
                                subTitle: makeDescription(weatherItem: data)
                            )
                            .onTapGesture {
                                viewModel.selectedCardIndex = viewModel.weatherData.firstIndex(of: data)!
                                isInfoScreenPresented = true
                            }
                        }.fullScreenCover(
                            isPresented: $isInfoScreenPresented,
                            content: {
                                WeatherDetailScreen(weatherData: viewModel.weatherData[viewModel.selectedCardIndex])
                            }
                        )
                    }
                }
                .padding(.top)
                .padding(.horizontal, 20)
            }
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.apiError != nil },
                set: { _ in viewModel.apiError = nil }
            )) {
                Alert(
                    title: Text(AppStrings.Error),
                    message: Text(viewModel.apiError?.localizedDescription ?? "\(AppStrings.ErrorMessage)"),
                    dismissButton: .default(Text(AppStrings.OK))
                )
            }
        }
        .frame(maxWidth: .infinity)
        .loader(viewModel.isDataLoading)
        .onAppear {
            getWeatherData()
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    }
    
    // MARK: - Functions
    
    private func getWeatherData() {
        Task { @MainActor in
            await viewModel.getWeatherData()
        }
    }
    
    private func makeDescription(weatherItem: WeatherData) -> String {
        var description = ""
        
        description += getLocalString(AppStrings.Summary) + ": " + "\(weatherItem.weather[0].description) \n"
        description += getLocalString(AppStrings.Temperature) + ": " + "\(kelvinToCelsius(kelvinTemp: weatherItem.main.temp)) °C \n"
        description += getLocalString(AppStrings.Humidity) + ": " + "\(weatherItem.main.humidity)%"
        
        return description
    }
}

#Preview {
    WeatherScreen()
}
