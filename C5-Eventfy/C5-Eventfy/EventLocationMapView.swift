//
//  EventLocationMapView.swift
//  C5-Eventfy
//
//  Created by Gabriel on 19/06/23.
//

import MapKit
import SwiftUI

struct EventLocationMapView: View {
    @StateObject private var viewModel: ViewModel
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: [viewModel.coordinate]) { location in
                MapMarker(coordinate: CLLocationCoordinate2D(viewModel.coordinate))
            }
        }
    }
    
    init(coordinate: Coordinate) {
        _viewModel = StateObject(wrappedValue: ViewModel(coordinate: coordinate))
    }
}

struct EventLocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        EventLocationMapView(coordinate: Coordinate.example)
    }
}
