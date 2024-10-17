// GeocodingResponse.swift
import Foundation
import CoreLocation

struct GeocodingResponse: Decodable {
    let response: Response

    struct Response: Decodable {
        let GeoObjectCollection: GeoObjectCollection
    }

    struct GeoObjectCollection: Decodable {
        let featureMember: [FeatureMember]
    }

    struct FeatureMember: Decodable {
        let GeoObject: GeoObject
    }

    struct GeoObject: Decodable {
        let Point: Point
    }

    struct Point: Decodable {
        let pos: String

        var coordinate: CLLocationCoordinate2D? {
            let components = pos.split(separator: " ").compactMap { Double($0) }
            if components.count == 2 {
                return CLLocationCoordinate2D(latitude: components[1], longitude: components[0])
            }
            return nil
        }
    }

    var firstPosition: CLLocationCoordinate2D? {
        return response.GeoObjectCollection.featureMember.first?.GeoObject.Point.coordinate
    }
}
