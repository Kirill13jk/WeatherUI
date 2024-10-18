// OnboardingView.swift
import SwiftUI

struct OnboardingView: View {
    @Binding var isAuthorized: Bool
    @ObservedObject var locationManager: LocationManager

    var body: some View {
        VStack(spacing: 30) {
            Text("Разрешите доступ к вашему местоположению для отображения погоды в вашем регионе.")
                .multilineTextAlignment(.center)
                .padding()

            VStack(spacing: 20) { 
                Button(action: {
                    locationManager.requestAuthorization()
                }) {
                    Text("Разрешить доступ")
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
                    Text("Запретить")
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
