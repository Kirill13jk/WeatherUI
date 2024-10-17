// HourlyForecastHorizontalView.swift
import SwiftUI

struct HourlyForecastHorizontalView: View {
    var weatherData: WeatherData

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(weatherData.hourlyForecast.sorted { $0.time < $1.time }) { hour in
                    VStack {
                        Text(hour.timeFormatted)
                            .font(.caption)
                        Image(systemName: hour.weatherIcon)
                            .renderingMode(.original)
                        Text("\(Int(hour.temperature))°")
                            .font(.headline)
                    }
                    .padding()
                    .background(hour.isCurrentHour ? Color.blue : Color.clear)
                    .cornerRadius(10)
                    .foregroundColor(hour.isCurrentHour ? .white : .primary)
                }
            }
            .padding(.horizontal)
        }
    }
}
