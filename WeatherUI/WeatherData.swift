// WeatherData.swift (обновленный)
import Foundation
import SwiftData

@Model
class WeatherData: Identifiable {
    var id = UUID()
    var cityName: String
    var country: String
    var temperature: Double
    var humidity: Int
    var windSpeed: Double
    var precipitation: Double
    var weatherDescription: String
    var sunriseTime: String
    var sunsetTime: String
    var currentTime: String
    var minTemp: Double
    var maxTemp: Double
    var cloud: Int
    var hourlyForecast: [HourlyWeather] = []

    init(cityName: String, country: String, temperature: Double, humidity: Int, windSpeed: Double, precipitation: Double, weatherDescription: String, sunriseTime: String, sunsetTime: String, currentTime: String, minTemp: Double, maxTemp: Double, cloud: Int) {
        self.cityName = cityName
        self.country = country
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.precipitation = precipitation
        self.weatherDescription = weatherDescription
        self.sunriseTime = sunriseTime
        self.sunsetTime = sunsetTime
        self.currentTime = currentTime
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.cloud = cloud
    }

    convenience init(from response: WeatherResponse) {
        self.init(
            cityName: response.location.name,
            country: response.location.country,
            temperature: response.current.temp_c,
            humidity: response.current.humidity,
            windSpeed: response.current.wind_kph / 3.6,
            precipitation: response.current.precip_mm,
            weatherDescription: response.current.condition.text,
            sunriseTime: response.forecast.forecastday.first?.astro.sunrise ?? "",
            sunsetTime: response.forecast.forecastday.first?.astro.sunset ?? "",
            currentTime: response.location.localtime,
            minTemp: response.forecast.forecastday.first?.day.mintemp_c ?? 0.0,
            maxTemp: response.forecast.forecastday.first?.day.maxtemp_c ?? 0.0,
            cloud: response.current.cloud
        )

        if let forecastDay = response.forecast.forecastday.first {
            self.hourlyForecast = forecastDay.hour.map { HourlyWeather(from: $0) }
        }
    }
}
