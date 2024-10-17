// LocationManager.swift
import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()

    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var location: CLLocation?
    @Published var isDenied: Bool = false

    override init() {
        self.authorizationStatus = manager.authorizationStatus
        super.init()
        manager.delegate = self
    }

    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        manager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            requestLocation()
        } else if authorizationStatus == .denied || authorizationStatus == .restricted {
            isDenied = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
        isDenied = true
    }
}
