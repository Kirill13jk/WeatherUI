// WeatherCardView.swift (обновленный)
import SwiftUI

struct WeatherCardView: View {
    var weather: WeatherData

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(20)
                .shadow(radius: 10)

            VStack(spacing: 10) {
                HStack {
                    Text("\(Int(weather.minTemp))° / \(Int(weather.maxTemp))°")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 18))
                    Spacer()
                    Text(weather.cityName)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.horizontal)

                Text("\(Int(weather.temperature))°")
                    .font(.system(size: 80))
                    .bold()
                    .foregroundColor(.white)

                Text(weather.weatherDescription)
                    .font(.title3)
                    .foregroundColor(.white)

                HStack(spacing: 20) {
                    VStack {
                        Image(systemName: "sunrise.fill")
                            .foregroundColor(.yellow)
                        Text(weather.sunriseTime)
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
                        Text("\(weather.windSpeed, specifier: "%.1f") м/с")
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
                        Text(weather.sunsetTime)
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)

                Spacer()

                Text(weather.currentTime)
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .padding(.bottom)
            }
            .padding()
        }
    }
}
