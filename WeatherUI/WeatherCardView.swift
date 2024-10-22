// WeatherCardView.swift

import SwiftUI

struct WeatherCardView: View {
    var weather: WeatherData
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(20)
                .shadow(radius: 10)

            VStack(spacing: 10) {
                HStack {
                    Text(minMaxTemperature)
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 18))
                    Spacer()
                    Text(weather.cityName)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.horizontal)

                if let currentHour = currentHourWeather {
                    VStack(spacing: 5) {
                        Image(systemName: currentHour.weatherIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                        Text(formattedTime(for: currentHour.time))
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .frame(height: 80)
                }

                Text(formattedTemperature)
                    .font(.system(size: UIScreen.main.bounds.height * 0.08))
                    .bold()
                    .foregroundColor(.white)

                Text(weather.weatherDescription)
                    .font(.title3)
                    .foregroundColor(.white)

                HStack(spacing: 20) {
                    VStack {
                        Image(systemName: "sunrise.fill")
                            .foregroundColor(.yellow)
                        Text(formattedTime(for: weather.sunriseTime))
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "cloud.fill")
                            .foregroundColor(.white)
                        Text("\(weather.cloud)%")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "wind")
                            .foregroundColor(.white)
                        Text(formattedWindSpeed)
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "humidity.fill")
                            .foregroundColor(.white)
                        Text("\(weather.humidity)%")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "sunset.fill")
                            .foregroundColor(.orange)
                        Text(formattedTime(for: weather.sunsetTime))
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)

                Text(formattedCurrentTime)
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .padding(.bottom)
            }
            .padding()
        }
        .frame(height: UIScreen.main.bounds.height * 0.4)
    }

    var currentHourWeather: HourlyWeather? {
        let currentHour = Calendar.current.component(.hour, from: Date())
        return weather.hourlyForecast.first { $0.hour == currentHour }
    }

    var formattedTemperature: String {
        if viewModel.temperatureUnit == "C" {
            return "\(Int(weather.currentTemperature))°C"
        } else {
            let tempF = weather.currentTemperature * 9 / 5 + 32
            return "\(Int(tempF))°F"
        }
    }

    var minMaxTemperature: String {
        let minTemp: String
        let maxTemp: String
        if viewModel.temperatureUnit == "C" {
            minTemp = "\(Int(weather.minTemp))°"
            maxTemp = "\(Int(weather.maxTemp))°"
        } else {
            let minF = weather.minTemp * 9 / 5 + 32
            let maxF = weather.maxTemp * 9 / 5 + 32
            minTemp = "\(Int(minF))°"
            maxTemp = "\(Int(maxF))°"
        }
        return "\(minTemp) / \(maxTemp)"
    }

    var formattedWindSpeed: String {
        if viewModel.windSpeedUnit == "м/с" {
            let speed = String(format: "%.1f", weather.windSpeed)
            return "\(speed) м/с"
        } else {
            let windKmH = weather.windSpeed * 3.6
            let speed = String(format: "%.1f", windKmH)
            return "\(speed) Km/h"
        }
    }

    func formattedTime(for timeString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let date = dateFormatter.date(from: timeString) {
            if viewModel.timeFormat == "12h" {
                dateFormatter.dateFormat = "h:mm a"
            } else {
                dateFormatter.dateFormat = "HH:mm"
            }
            return dateFormatter.string(from: date)
        }
        return timeString
    }

    var formattedCurrentTime: String {
        formattedTime(for: weather.currentTime)
    }
}
