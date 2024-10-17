// WeatherUIApp.swift
import SwiftUI
import SwiftData

@main
struct WeatherUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: WeatherData.self)
        }
    }
}
