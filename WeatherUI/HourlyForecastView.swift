import SwiftUI

struct HourlyForecastView: View {
    var weatherData: WeatherData

    var body: some View {
        ScrollView {
            VStack {
                Text("Прогноз на 24 часа")
                    .font(.headline)
                Text("\(weatherData.cityName), \(weatherData.country)")
                    .font(.subheadline)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(weatherData.hourlyForecast.sorted { $0.time < $1.time }) { hour in
                            VStack {
                                Text(hour.time)
                                Image(systemName: "cloud.fill") // Замените на соответствующую иконку
                                Text("\(hour.temperature, specifier: "%.0f")°")
                            }
                            .padding()
                            .background(hour.isCurrentHour ? Color.blue : Color.clear)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }

                ForEach(weatherData.hourlyForecast.sorted { $0.time < $1.time }) { hour in
                    VStack {
                        HStack {
                            Text("\(hour.time)")
                            Spacer()
                            Image(systemName: "cloud.fill") // Замените на соответствующую иконку
                            Text("\(hour.temperature, specifier: "%.0f")°")
                        }
                        HStack {
                            Text(hour.condition)
                            Spacer()
                            Text("По ощущению \(hour.feelsLike, specifier: "%.0f")°")
                        }
                        HStack {
                            Image(systemName: "wind")
                            Text("\(hour.windSpeed, specifier: "%.1f") м/с \(hour.windDirection)")
                            Spacer()
                            Image(systemName: "drop.fill")
                            Text("\(hour.precipitation, specifier: "%.0f")%")
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
