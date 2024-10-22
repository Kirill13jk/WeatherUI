// WeatherViewModel.swift

import Foundation
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weatherDataList: [WeatherData] = []
    @Published var temperatureUnit: String = "C"
    @Published var windSpeedUnit: String = "м/с"
    @Published var visibilityUnit: String = "Km"
    @Published var timeFormat: String = "24h"
    @Published var dateFormat: String = "mm/dd/yy"
    @Published var notificationsEnabled: Bool = false
    @Published var dayWeatherEnabled: Bool = false

    private let locationManager: LocationManager
    private let weatherService = WeatherService()
    private let geocodingService = GeocodingService()
    private var cancellables = Set<AnyCancellable>()

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        observeLocation()
    }

    private func observeLocation() {
        locationManager.$location
            .sink { [weak self] location in
                if let location = location {
                    self?.fetchWeather(for: location.coordinate)
                } else if self?.locationManager.isDenied == true {
                    // Handle location denied
                }
            }
            .store(in: &cancellables)
    }

    func fetchWeather(for coordinate: CLLocationCoordinate2D) {
        weatherService.fetchWeather(for: coordinate) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let data = WeatherData(from: response)
                    self?.weatherDataList.append(data)
                case .failure(let error):
                    print("Error fetching weather: \(error.localizedDescription)")
                }
            }
        }
    }

    func addCity(named cityName: String) {
        geocodingService.geocode(address: cityName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coordinate):
                    self?.fetchWeather(for: coordinate)
                case .failure(let error):
                    print("Geocoding error: \(error.localizedDescription)")
                }
            }
        }
    }
}
