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
            .responseDecodable(of: GeocodingResponse.self) { response in
                switch response.result {
                case .success(let geoResponse):
                    if let coordinate = geoResponse.firstPosition {
                        completion(.success(coordinate))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get coordinates"])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
