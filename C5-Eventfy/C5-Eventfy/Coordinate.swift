//
//  Coordinate.swift
//  C5-Eventfy
//
//  Created by Gabriel on 19/06/23.
//

import CoreLocation
import Foundation

struct Coordinate: Codable, Identifiable {
    let latitude, longitude: Double?
    var id = UUID()
    
    static let example = Coordinate(CLLocationCoordinate2D(latitude: 48, longitude: 2))
}

extension Coordinate {
    init(_ coordinate: CLLocationCoordinate2D?) {
        self = .init(latitude: coordinate?.latitude, longitude: coordinate?.longitude)
    }
}

extension CLLocationCoordinate2D {
    init(_ coordinate: Coordinate) {
        self = .init(latitude: coordinate.latitude!, longitude: coordinate.longitude!)
    }
}
