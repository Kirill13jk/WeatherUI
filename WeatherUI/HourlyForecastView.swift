// HourlyForecastView.swift
import SwiftUI

struct HourlyForecastView: View {
    var weatherData: WeatherData

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Прогноз на 24 часа")
                    .font(.headline)
                    .padding(.top)

                Text("\(weatherData.cityName), \(weatherData.country)")
                    .font(.subheadline)
                    .padding(.bottom)

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
                            .background(hour.isCurrentHour ? Color.blue : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(hour.isCurrentHour ? .white : .primary)
                        }
                    }
                    .padding(.horizontal)
                }

                ForEach(weatherData.hourlyForecast.sorted { $0.time < $1.time }) { hour in
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(hour.timeFormatted)
                                .font(.headline)
                            Spacer()
                            Image(systemName: hour.weatherIcon)
                            Text("\(Int(hour.temperature))°")
                                .font(.headline)
                        }

                        HStack {
                            Text(hour.condition)
                            Spacer()
                            Text("По ощущению \(Int(hour.feelsLike))°")
                        }

                        HStack {
                            Image(systemName: "wind")
                            Text("\(hour.windSpeed, specifier: "%.1f") м/с \(hour.windDirection)")
                            Spacer()
                            Image(systemName: "drop.fill")
                            Text("\(Int(hour.precipitation))%")
                            Spacer()
                            Image(systemName: "cloud.fill")
                            Text("\(hour.cloudiness)%")
                        }
                        .font(.caption)

                        Divider()
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
