// WeatherDay.swift

import Foundation
import SwiftData

@Model
class WeatherDay: Identifiable {
    var id = UUID()
    var date: String
    var maxtemp_c: Double
    var mintemp_c: Double
    var avgtemp_c: Double
    var maxwind_kph: Double
    var uv: Double
    var condition: String
    var icon: String
    var daily_chance_of_rain: Double
    var cloud: Int
    var sunrise: String
    var sunset: String
    var windDirection: String?
    var airQualityIndex: Int
    var moonPhase: String
    var feelslike_c: Double
    var windDirectionFull: String
    var conditionNight: String
    var iconNight: String

    init(date: String, maxtemp_c: Double, mintemp_c: Double, avgtemp_c: Double, maxwind_kph: Double, uv: Double, condition: String, icon: String, daily_chance_of_rain: Double, cloud: Int, sunrise: String, sunset: String, windDirection: String?, airQualityIndex: Int, moonPhase: String, feelslike_c: Double, windDirectionFull: String, conditionNight: String, iconNight: String) {
        self.date = date
        self.maxtemp_c = maxtemp_c
        self.mintemp_c = mintemp_c
        self.avgtemp_c = avgtemp_c
        self.maxwind_kph = maxwind_kph
        self.uv = uv
        self.condition = condition
        self.icon = icon
        self.daily_chance_of_rain = daily_chance_of_rain
        self.cloud = cloud
        self.sunrise = sunrise
        self.sunset = sunset
        self.windDirection = windDirection
        self.airQualityIndex = airQualityIndex
        self.moonPhase = moonPhase
        self.feelslike_c = feelslike_c
        self.windDirectionFull = windDirectionFull
        self.conditionNight = conditionNight
        self.iconNight = iconNight
    }

    convenience init(from forecastDay: WeatherResponse.Forecast.ForecastDay) {
        self.init(
            date: forecastDay.date,
            maxtemp_c: forecastDay.day.maxtemp_c,
            mintemp_c: forecastDay.day.mintemp_c,
            avgtemp_c: forecastDay.day.avgtemp_c,
            maxwind_kph: forecastDay.day.maxwind_kph,
            uv: forecastDay.day.uv,
            condition: forecastDay.day.condition.text,
            icon: forecastDay.day.condition.icon,
            daily_chance_of_rain: forecastDay.day.daily_chance_of_rain,
            cloud: forecastDay.day.daily_will_it_rain,
            sunrise: forecastDay.astro.sunrise,
            sunset: forecastDay.astro.sunset,
            windDirection: nil,
            airQualityIndex: 42,
            moonPhase: forecastDay.astro.moon_phase,
            feelslike_c: forecastDay.day.avgtemp_c,
            windDirectionFull: "",
            conditionNight: forecastDay.day.condition.text,
            iconNight: forecastDay.day.condition.icon
        )
    }

    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let dateObj = formatter.date(from: date) {
            formatter.dateFormat = "dd/MM"
            return formatter.string(from: dateObj)
        }
        return date
    }

    var dateFormattedWithWeekday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ru_RU")
        if let dateObj = formatter.date(from: date) {
            formatter.dateFormat = "dd/MM EEE"
            return formatter.string(from: dateObj)
        }
        return date
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

    var weatherIconNight: String {
        switch conditionNight.lowercased() {
        case let str where str.contains("дождь"):
            return "cloud.moon.rain.fill"
        case let str where str.contains("ясно"):
            return "moon.fill"
        case let str where str.contains("облачно"):
            return "cloud.moon.fill"
        default:
            return "cloud.moon.fill"
        }
    }

    var dayDuration: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if let sunriseDate = formatter.date(from: sunrise),
           let sunsetDate = formatter.date(from: sunset) {
            let interval = sunsetDate.timeIntervalSince(sunriseDate)
            let hours = Int(interval / 3600)
            let minutes = Int((interval.truncatingRemainder(dividingBy: 3600)) / 60)
            return "\(hours) ч \(minutes) мин"
        }
        return ""
    }
}
