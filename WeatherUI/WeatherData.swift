// WeatherData.swift

import Foundation
import SwiftData

@Model
class WeatherData: Identifiable {
    var id = UUID()
    var cityName: String
    var country: String
    var currentTemperature: Double
    var humidity: Int
    var windSpeed: Double
    var windDirection: String?
    var precipitation: Double
    var weatherDescription: String
    var sunriseTime: String
    var sunsetTime: String
    var currentTime: String
    var minTemp: Double
    var maxTemp: Double
    var cloud: Int
    var hourlyForecast: [HourlyWeather] = []
    var date: String
    var forecast: [WeatherDay] = []
    var uvIndex: Int = 0
    var airQualityIndex: Int = 0
    var dayDuration: String = ""

    init(cityName: String, country: String, currentTemperature: Double, humidity: Int, windSpeed: Double, windDirection: String?, precipitation: Double, weatherDescription: String, sunriseTime: String, sunsetTime: String, currentTime: String, minTemp: Double, maxTemp: Double, cloud: Int, date: String) {
        self.cityName = cityName
        self.country = country
        self.currentTemperature = currentTemperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.precipitation = precipitation
        self.weatherDescription = weatherDescription
        self.sunriseTime = sunriseTime
        self.sunsetTime = sunsetTime
        self.currentTime = currentTime
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.cloud = cloud
        self.date = date
    }

    var weatherIcon: String {
        switch weatherDescription.lowercased() {
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

    convenience init(from response: WeatherResponse) {
        self.init(
            cityName: response.location.name,
            country: response.location.country,
            currentTemperature: response.current.temp_c,
            humidity: response.current.humidity,
            windSpeed: response.current.wind_kph / 3.6,
            windDirection: response.current.wind_dir,
            precipitation: response.current.precip_mm,
            weatherDescription: response.current.condition.text,
            sunriseTime: response.forecast.forecastday.first?.astro.sunrise ?? "",
            sunsetTime: response.forecast.forecastday.first?.astro.sunset ?? "",
            currentTime: response.location.localtime,
            minTemp: response.forecast.forecastday.first?.day.mintemp_c ?? 0.0,
            maxTemp: response.forecast.forecastday.first?.day.maxtemp_c ?? 0.0,
            cloud: response.current.cloud,
            date: response.forecast.forecastday.first?.date ?? ""
        )

        if let forecastDay = response.forecast.forecastday.first {
            self.hourlyForecast = forecastDay.hour.map { HourlyWeather(from: $0) }
            self.forecast = response.forecast.forecastday.map { WeatherDay(from: $0) }
        }
    }
}
