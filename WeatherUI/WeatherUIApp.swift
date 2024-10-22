// WeatherUIApp.swift

import SwiftUI
import SwiftData

@main
struct WeatherUIApp: App {
    @StateObject var locationManager: LocationManager
    @StateObject var viewModel: WeatherViewModel

    init() {
        let locManager = LocationManager()
        _locationManager = StateObject(wrappedValue: locManager)
        _viewModel = StateObject(wrappedValue: WeatherViewModel(locationManager: locManager))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(locationManager)
                .modelContainer(for: WeatherData.self)
        }
    }
}
