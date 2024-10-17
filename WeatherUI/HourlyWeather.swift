// HourlyWeather.swift
import Foundation
import SwiftData

@Model
class HourlyWeather: Identifiable {
    var id = UUID()
    var time: String
    var temperature: Double
    var condition: String
    var icon: String
    var windSpeed: Double
    var windDirection: String
    var precipitation: Double
    var cloudiness: Int
    var feelsLike: Double
    weak var weatherData: WeatherData?

    var isCurrentHour: Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = formatter.date(from: time) {
            return Calendar.current.isDate(Date(), equalTo: date, toGranularity: .hour)
        }
        return false
    }

    var timeFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = formatter.date(from: time) {
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
        return time
    }

    var weatherIcon: String {
        switch condition.lowercased() {
        case let str where str.contains("дождь"):
            return "cloud.rain.fill"
        case let str where str.contains("ясно"):
            return "sun.max.fill"
        case let str where str.contains("облачно"):
            return "cloud.fill"
        default:
            return "cloud.sun.fill"
        }
    }

    init(time: String, temperature: Double, condition: String, icon: String, windSpeed: Double, windDirection: String, precipitation: Double, cloudiness: Int, feelsLike: Double) {
        self.time = time
        self.temperature = temperature
        self.condition = condition
        self.icon = icon
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.precipitation = precipitation
        self.cloudiness = cloudiness
        self.feelsLike = feelsLike
    }

    convenience init(from hourData: WeatherResponse.Forecast.ForecastDay.Hour) {
        self.init(
            time: hourData.time,
            temperature: hourData.temp_c,
            condition: hourData.condition.text,
            icon: hourData.condition.icon,
            windSpeed: hourData.wind_kph / 3.6,
            windDirection: hourData.wind_dir,
            precipitation: hourData.chance_of_rain,
            cloudiness: hourData.cloud,
            feelsLike: hourData.feelslike_c
        )
    }
}
