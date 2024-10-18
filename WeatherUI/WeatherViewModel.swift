// WeatherViewModel.swift
import Foundation
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weatherDataList: [WeatherData] = []
    private let locationManager: LocationManager
    private let weatherService = WeatherService()
    private let geocodingService = GeocodingService()
    private var cancellables = Set<AnyCancellable>()

    // Настройки
    @Published var temperatureUnit: String = "C"
    @Published var windSpeedUnit: String = "Km"
    @Published var timeFormat: String = "24h"
    @Published var notificationsEnabled: Bool = true

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
                    // Не удалось получить местоположение
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
                    print("Ошибка при получении погоды: \(error.localizedDescription)")
                }
            }
        }
    }

    func addCity(named cityName: String, completion: @escaping (UUID?) -> Void) {
        geocodingService.geocode(address: cityName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coordinate):
                    self?.fetchWeather(for: coordinate)
                    if let newWeather = self?.weatherDataList.last {
                        completion(newWeather.id)
                    } else {
                        completion(nil)
                    }
                case .failure(let error):
                    print("Ошибка геокодирования: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }
}
