// WeatherResponse.swift (обновленный)
import Foundation

struct WeatherResponse: Decodable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast

    struct Location: Decodable {
        let name: String
        let country: String
        let localtime: String
    }

    struct CurrentWeather: Decodable {
        let temp_c: Double
        let condition: Condition
        let wind_kph: Double
        let humidity: Int
        let cloud: Int
        let precip_mm: Double

        struct Condition: Decodable {
            let text: String
            let icon: String
            let code: Int
        }
    }

    struct Forecast: Decodable {
        let forecastday: [ForecastDay]

        struct ForecastDay: Decodable {
            let date: String
            let date_epoch: Int
            let day: Day
            let astro: Astro
            let hour: [Hour]

            struct Day: Decodable {
                let maxtemp_c: Double
                let mintemp_c: Double
            }

            struct Astro: Decodable {
                let sunrise: String
                let sunset: String
            }

            struct Hour: Decodable {
                let time: String
                let temp_c: Double
                let condition: Condition
                let wind_kph: Double
                let wind_dir: String
                let chance_of_rain: Double
                let cloud: Int
                let feelslike_c: Double

                struct Condition: Decodable {
                    let text: String
                    let icon: String
                    let code: Int
                }
            }
        }
    }
}
