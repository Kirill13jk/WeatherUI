// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
 

            VStack(spacing: 10) {
                HStack {
                    Text("Температура:")
                        .foregroundColor(.black)
                    Spacer()
                    Picker("", selection: $viewModel.temperatureUnit) {
                        Text("C").tag("C")
                        Text("F").tag("F")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                }

                HStack {
                    Text("Скорость ветра:")
                        .foregroundColor(.black)
                    Spacer()
                    Picker("", selection: $viewModel.windSpeedUnit) {
                        Text("Mi").tag("Mi")
                        Text("Km").tag("Km")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                }

                HStack {
                    Text("Формат времени:")
                        .foregroundColor(.black)
                    Spacer()
                    Picker("", selection: $viewModel.timeFormat) {
                        Text("12h").tag("12h")
                        Text("24h").tag("24h")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                }

                HStack {
                    Text("Уведомления:")
                        .foregroundColor(.black)
                    Spacer()
                    Picker("", selection: $viewModel.notificationsEnabled) {
                        Text("Вкл").tag(true)
                        Text("Выкл").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)

            Button(action: {
                // Сохранить настройки и закрыть
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Установить")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
        }
        .padding()
        .navigationBarTitle("Настройки", displayMode: .inline)
    }
}
