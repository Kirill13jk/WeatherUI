// ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var isAuthorized = false
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        if isAuthorized {
            MainView()
                .environmentObject(locationManager)
        } else {
            OnboardingView(isAuthorized: $isAuthorized)
                .environmentObject(locationManager)
        }
    }
}
