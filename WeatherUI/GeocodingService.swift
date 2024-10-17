// GeocodingService.swift
import Foundation
import Alamofire
import CoreLocation

class GeocodingService {
    private let apiKey = "5cd7ab3b-76b1-4729-b1be-604334061bd0"

    func geocode(address: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        let url = "https://geocode-maps.yandex.ru/1.x/"
        let parameters: [String: Any] = [
            "apikey": apiKey,
            "geocode": address,
            "format": "json"
        ]

        AF.request(url, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let coordinate = self.parseCoordinate(from: value) {
                        completion(.success(coordinate))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get coordinates"])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    private func parseCoordinate(from value: Any) -> CLLocationCoordinate2D? {
        if let json = value as? [String: Any],
           let response = json["response"] as? [String: Any],
           let geoObjectCollection = response["GeoObjectCollection"] as? [String: Any],
           let featureMember = geoObjectCollection["featureMember"] as? [[String: Any]],
           let firstMember = featureMember.first,
           let geoObject = firstMember["GeoObject"] as? [String: Any],
           let point = geoObject["Point"] as? [String: Any],
           let pos = point["pos"] as? String {
            let components = pos.split(separator: " ").compactMap { Double($0) }
            if components.count == 2 {
                return CLLocationCoordinate2D(latitude: components[1], longitude: components[0])
            }
        }
        return nil
    }
}
