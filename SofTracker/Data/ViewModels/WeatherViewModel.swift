//
// Created by TMA on 02/20/25.
//
import Foundation
import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    // MARK: - Properties

    @Published var weatherData: [WeatherData] = []
    @Published var isDataLoading = false
    @Published var selectedCardIndex = 0
    @Published var apiError: AppError?

    let cities = ["Delhi", "Jaipur", "Mumbai", "Chennai", "Bengaluru", "Kolkata"]

    // MARK: - Functions

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

    func conditionImage(conditionId: Int) -> String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    func conditionColor(conditionId: Int) -> Color {
            switch conditionId {
            case 200...232:
                return .purple  // Thunderstorm
            case 300...321:
                return .blue    // Drizzle
            case 500...531:
                return .blue.opacity(0.8)  // Rain
            case 600...622:
                return .teal    // Snow
            case 701...781:
                return .gray    // Atmosphere
            case 800:
                return .yellow  // Clear
            case 801...804:
                return .gray.opacity(0.7)  // Clouds
            default:
                return .indigo
            }
        }
}
