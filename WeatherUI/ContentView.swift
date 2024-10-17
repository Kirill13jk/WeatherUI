// ContentView.swift (обновленный)
import SwiftUI

struct ContentView: View {
    @State private var isAuthorized = false
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        if isAuthorized {
            MainView(locationManager: locationManager)
        } else {
            OnboardingView(isAuthorized: $isAuthorized, locationManager: locationManager)
        }
    }
}
