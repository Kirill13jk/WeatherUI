// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var isAuthorized = false
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel: WeatherViewModel

    init() {
        let lm = LocationManager()
        _locationManager = StateObject(wrappedValue: lm)
        _viewModel = StateObject(wrappedValue: WeatherViewModel(locationManager: lm))
    }

    var body: some View {
        if isAuthorized {
            MainView()
                .environmentObject(viewModel)
        } else {
            OnboardingView(isAuthorized: $isAuthorized, locationManager: locationManager)
                .environmentObject(viewModel)
        }
    }
}
