// OnboardingView.swift

import SwiftUI

struct OnboardingView: View {
    @Binding var isAuthorized: Bool
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack(spacing: 30) {
            Text("Please allow access to your location to display weather information for your region.")
                .multilineTextAlignment(.center)
                .padding()

            HStack(spacing: 20) {
                Button(action: {
                    locationManager.requestAuthorization()
                }) {
                    Text("Allow Access")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    isAuthorized = true
                    locationManager.isDenied = true
                }) {
                    Text("Deny")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .onReceive(locationManager.$authorizationStatus) { newStatus in
            if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways {
                isAuthorized = true
            } else if newStatus == .denied || newStatus == .restricted {
                isAuthorized = true
                locationManager.isDenied = true
            }
        }
    }
}
