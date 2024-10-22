import SwiftUI

struct HourlyForecastHorizontalView: View {
    var weatherData: WeatherData

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(weatherData.hourlyForecast.sorted { $0.time < $1.time }) { hour in
                    VStack(spacing: 5) {
                        Text(hour.timeFormatted)
                            .font(.caption2)
                        Image(systemName: hour.weatherIcon)
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("\(Int(hour.temperature))°")
                            .font(.caption2)
                    }
                    .padding(5)
                    .background(hour.isCurrentHour ? Color.blue : Color.clear)
                    .cornerRadius(10)
                    .foregroundColor(hour.isCurrentHour ? .white : .primary)
                }
            }
            .padding(.horizontal)
        }
    }
}
