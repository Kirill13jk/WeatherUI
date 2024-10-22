// DailyForecastCardView.swift

import SwiftUI

struct DailyForecastCardView: View {
    var weatherDay: WeatherDay

    var body: some View {
        HStack {
            // Дата, иконка погоды и вероятность осадков
            VStack(alignment: .leading) {
                Text(weatherDay.dateFormatted)
                    .font(.subheadline)
                Image(systemName: weatherDay.weatherIcon)
                    .foregroundColor(.blue)
                Text("\(Int(weatherDay.daily_chance_of_rain))%")
                    .foregroundColor(.blue)
                    .font(.caption)
            }
            .padding(.leading, 10)

            Spacer()

            // Описание погоды
            Text(weatherDay.condition)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)

            Spacer()

            // Диапазон температур и стрелка перехода
            VStack(alignment: .trailing) {
                Text("\(Int(weatherDay.mintemp_c))° – \(Int(weatherDay.maxtemp_c))°")
                    .font(.subheadline)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 10)
        }
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
        )
        .padding(.horizontal, 10)
    }
}
