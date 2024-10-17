// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @State private var temperatureUnit: String = "C"
    @State private var windSpeedUnit: String = "Km"
    @State private var timeFormat: String = "24h"
    @State private var notificationsEnabled: Bool = true

    var body: some View {
        ZStack {
            Color.blue
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Настройки")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                VStack(spacing: 10) {
                    HStack {
                        Text("Температура:")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("", selection: $temperatureUnit) {
                            Text("C").tag("C")
                            Text("F").tag("F")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }

                    HStack {
                        Text("Скорость ветра:")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("", selection: $windSpeedUnit) {
                            Text("Mi").tag("Mi")
                            Text("Km").tag("Km")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }

                    HStack {
                        Text("Формат времени:")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("", selection: $timeFormat) {
                            Text("12h").tag("12h")
                            Text("24h").tag("24h")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }

                    HStack {
                        Text("Уведомления:")
                            .foregroundColor(.white)
                        Spacer()
                        Picker("", selection: $notificationsEnabled) {
                            Text("Вкл").tag(true)
                            Text("Выкл").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)

                Button(action: {
                    // Сохранить настройки
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
        }
    }
}
