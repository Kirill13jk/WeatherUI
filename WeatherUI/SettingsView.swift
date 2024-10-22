// SettingsView.swift

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "cloud.sun.fill")
                        .foregroundColor(.white)
                    Text("Погода")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                }

                Button(action: {
                    // Edit location action
                }) {
                    HStack {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                        Text("Редактировать")
                            .foregroundColor(.white)
                    }
                }

                ForEach(viewModel.weatherDataList) { weatherData in
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.white)
                        Text(weatherData.cityName)
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }

                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.white)
                        Text("Уведомления")
                            .foregroundColor(.white)
                        Spacer()
                        Toggle("", isOn: $viewModel.notificationsEnabled)
                            .labelsHidden()
                    }
                    HStack {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.white)
                        Text("Дневная погода")
                            .foregroundColor(.white)
                        Spacer()
                        Toggle("", isOn: $viewModel.dayWeatherEnabled)
                            .labelsHidden()
                    }
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)

                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "thermometer")
                            .foregroundColor(.white)
                        Text("Единица температуры")
                            .foregroundColor(.white)
                        Spacer()
                        Picker(selection: $viewModel.temperatureUnit, label: Text("")) {
                            Text("C").tag("C")
                            Text("F").tag("F")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                    HStack {
                        Image(systemName: "wind")
                            .foregroundColor(.white)
                        Text("Единица скорости ветра")
                            .foregroundColor(.white)
                        Spacer()
                        Picker(selection: $viewModel.windSpeedUnit, label: Text("")) {
                            Text("м/с").tag("м/с")
                            Text("Km/h").tag("Km/h")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                    HStack {
                        Image(systemName: "eye.fill")
                            .foregroundColor(.white)
                        Text("Блок видимости")
                            .foregroundColor(.white)
                        Spacer()
                        Picker(selection: $viewModel.visibilityUnit, label: Text("")) {
                            Text("Km").tag("Km")
                            Text("Mi").tag("Mi")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)

                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.white)
                        Text("Формат времени")
                            .foregroundColor(.white)
                        Spacer()
                        Picker(selection: $viewModel.timeFormat, label: Text("")) {
                            Text("12h").tag("12h")
                            Text("24h").tag("24h")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.white)
                        Text("Формат даты")
                            .foregroundColor(.white)
                        Spacer()
                        Picker(selection: $viewModel.dateFormat, label: Text("")) {
                            Text("dd/mm/yy").tag("dd/mm/yy")
                            Text("mm/dd/yy").tag("mm/dd/yy")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)

                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                        Text("Назад")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
