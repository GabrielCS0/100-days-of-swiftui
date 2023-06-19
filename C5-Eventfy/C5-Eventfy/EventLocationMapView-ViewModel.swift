//
//  EventLocationMapView-ViewModel.swift
//  C5-Eventfy
//
//  Created by Gabriel on 19/06/23.
//


import Foundation
import MapKit

extension EventLocationMapView {
    @MainActor class ViewModel: ObservableObject {
        let coordinate: Coordinate
        
        @Published var mapRegion: MKCoordinateRegion
        
        init(coordinate: Coordinate) {
            self.coordinate = coordinate
            
            _mapRegion = Published(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude!, longitude: coordinate.longitude!), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
        }
    }
}
