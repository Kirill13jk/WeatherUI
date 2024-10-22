// WeatherService.swift

import Foundation
import Alamofire
import CoreLocation

class WeatherService {
    private let apiKey = "963e94c58a124972bb185043240410"

    func fetchWeather(for location: CLLocationCoordinate2D, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let url = "https://api.weatherapi.com/v1/forecast.json"
        let parameters: [String: Any] = [
            "key": apiKey,
            "q": "\(location.latitude),\(location.longitude)",
            "days": "7",
            "aqi": "no",
            "alerts": "no",
            "lang": "ru"
        ]

        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: WeatherResponse.self) { response in
                switch response.result {
                case .success(let weatherResponse):
                    completion(.success(weatherResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
