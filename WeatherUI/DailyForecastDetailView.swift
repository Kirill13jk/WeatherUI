// DailyForecastDetailView.swift

import SwiftUI

struct DailyForecastDetailView: View {
    var weatherData: WeatherData
    @State private var selectedDay: WeatherDay

    init(weatherData: WeatherData, selectedDay: WeatherDay? = nil) {
        self.weatherData = weatherData

        if let selected = selectedDay {
            _selectedDay = State(initialValue: selected)
        } else if let firstDay = weatherData.forecast.first {
            _selectedDay = State(initialValue: firstDay)
        } else {
            _selectedDay = State(initialValue: WeatherDay(
                date: "",
                maxtemp_c: 0,
                mintemp_c: 0,
                avgtemp_c: 0,
                maxwind_kph: 0,
                uv: 0,
                condition: "",
                icon: "",
                daily_chance_of_rain: 0,
                cloud: 0,
                sunrise: "",
                sunset: "",
                windDirection: nil,
                airQualityIndex: 0,
                moonPhase: "",
                feelslike_c: 0,
                windDirectionFull: "",
                conditionNight: "",
                iconNight: ""
            ))
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerView
                daySection
                nightSection
                sunAndMoonView
                airQualityView
                Spacer()
            }
        }
        .navigationBarTitle("Дневная погода", displayMode: .inline)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(weatherData.cityName), \(weatherData.country)")
                .font(.title)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(weatherData.forecast) { day in
                        dayButton(for: day)
                    }
                }
            }
        }
        .padding()
    }

    private func dayButton(for day: WeatherDay) -> some View {
        let isSelected = selectedDay.id == day.id
        return Text(day.dateFormattedWithWeekday)
            .padding(8)
            .background(isSelected ? Color.blue : Color.gray.opacity(0.3))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(8)
            .onTapGesture {
                self.selectedDay = day
            }
    }

    private var daySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("День")
                .font(.headline)
                .padding(.horizontal)

            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .center) {
                    Image(systemName: selectedDay.weatherIcon)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text(selectedDay.condition)
                        .font(.title3)
                }

                Text("\(Int(selectedDay.maxtemp_c))°")
                    .font(.system(size: 60))
                    .bold()

                VStack(alignment: .leading, spacing: 5) {
                    Text("По ощущениям: \(Int(selectedDay.feelslike_c))°")
                    Text("Ветер: \(Int(selectedDay.maxwind_kph / 3.6)) м/с \(selectedDay.windDirectionFull)")
                    Text("УФ-индекс: \(Int(selectedDay.uv)) (умерен.)")
                    Text("Вероятность дождя: \(Int(selectedDay.daily_chance_of_rain))%")
                    Text("Облачность: \(selectedDay.cloud)%")
                }
                .font(.subheadline)
            }
            .padding()
        }
    }

    private var nightSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ночь")
                .font(.headline)
                .padding(.horizontal)

            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .center) {
                    Image(systemName: selectedDay.weatherIconNight)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text(selectedDay.conditionNight)
                        .font(.title3)
                }

                Text("\(Int(selectedDay.mintemp_c))°")
                    .font(.system(size: 60))
                    .bold()

                VStack(alignment: .leading, spacing: 5) {
                    Text("По ощущениям: \(Int(selectedDay.feelslike_c))°")
                    Text("Ветер: \(Int(selectedDay.maxwind_kph / 3.6)) м/с \(selectedDay.windDirectionFull)")
                    Text("УФ-индекс: \(Int(selectedDay.uv)) (умерен.)")
                    Text("Вероятность дождя: \(Int(selectedDay.daily_chance_of_rain))%")
                    Text("Облачность: \(selectedDay.cloud)%")
                }
                .font(.subheadline)
            }
            .padding()
        }
    }

    private var sunAndMoonView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Солнце и Луна")
                .font(.headline)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 5) {
                Text("Восход солнца: \(selectedDay.sunrise)")
                Text("Закат солнца: \(selectedDay.sunset)")
                Text("Продолжительность дня: \(selectedDay.dayDuration)")
                Text("Фаза Луны: \(selectedDay.moonPhase)")
            }
            .padding(.horizontal)
        }
        .padding()
    }

    private var airQualityView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Качество воздуха")
                .font(.headline)
                .padding(.horizontal)

            HStack {
                Text("\(selectedDay.airQualityIndex)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                    .padding(.leading)

                VStack(alignment: .leading) {
                    Text("Хорошо")
                        .font(.headline)
                    Text("Качество воздуха считается удовлетворительным и загрязнения воздуха незначительные в пределах нормы.")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .padding()
    }
}
