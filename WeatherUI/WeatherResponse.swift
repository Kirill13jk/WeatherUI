// WeatherResponse.swift

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
        let wind_dir: String
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
                let avgtemp_c: Double
                let maxwind_kph: Double
                let uv: Double
                let condition: Condition
                let daily_chance_of_rain: Double
                let daily_will_it_rain: Int
                let daily_chance_of_snow: Double
                let daily_will_it_snow: Int

                struct Condition: Decodable {
                    let text: String
                    let icon: String
                    let code: Int
                }
            }

            struct Astro: Decodable {
                let sunrise: String
                let sunset: String
                let moon_phase: String
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
