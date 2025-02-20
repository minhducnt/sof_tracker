//
// Created by TMA on 02/20/25.
//
import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherData: [WeatherData] = []
    @Published var isDataLoading = false
    @Published var selectedCardIndex = 0
    @Published var apiError: AppError?
    let cities = ["Delhi", "Jaipur", "Mumbai", "Chennai", "Bengaluru", "Kolkata"]

    func getWeatherData() async {
        isDataLoading = true
        weatherData.removeAll()
        for city in cities {
            do {
                let data = try await WeatherService().getWeather(city: city, appId: Constants.weatherAppId)
                weatherData.append(data)
            }
            catch {
                ErrorHandler.logError(message: "No weather data", error: error)
                apiError = error as? AppError
            }
        }
        isDataLoading = false
    }
}
