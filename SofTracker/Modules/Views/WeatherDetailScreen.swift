//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct WeatherDetailScreen: View {
    // MARK: - Properties

    var weatherData: WeatherData
    @Environment(\.dismiss) var dismiss

    // MARK: - Body

    var body: some View {
        VStack {
            Header(
                text: LocalizedStringKey(getLocalString(weatherData.name) + " " + getLocalString(AppStrings.Weather)),
                hasBackButton: true,
                onBackArrowClick: {
                    dismiss()
                })

            Spacer()

            infoText(text: AppStrings.TemperatureIs, info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.temp).description) °C")
            infoText(text: AppStrings.RealFeelIs, info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.feelsLike).description) °C")
            infoText(text: AppStrings.MaxItWillGoIs, info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.tempMax).description) °C")
            infoText(text: AppStrings.MinItWillFallIs, info: "\(kelvinToCelsius(kelvinTemp: weatherData.main.tempMin).description) °C")
            infoText(text: AppStrings.YouCanSeeAsFarAs, info: "\(weatherData.visibility / 1000) km")
            infoText(text: AppStrings.ThePressureYouBeFeelingIs, info: "\(weatherData.main.pressure) hectopascal")

            Spacer()
        }
        .padding()
        .onAppear {
            AnalyticsManager.logScreenView(screenName: String(describing: Self.self))
        }
    }

    // MARK: - Views

    func infoText(text: LocalizedStringKey, info: String) -> some View {
        VStack {
            (Text(text) + Text(" \(info)"))
                .font(.notoSansBold16)
                .frame(maxWidth: .infinity)
            Divider()
        }
    }
}
