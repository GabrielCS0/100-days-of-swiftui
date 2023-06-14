//
//  EditView-ViewModel.swift
//  Bucketlist
//
//  Created by Gabriel on 14/06/23.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published var name: String
        @Published var description: String

        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        var location: Location

        init(name: String, description: String, location: Location) {
            self.name = name
            self.description = description
            self.location = location
        }
        
        func updateLocation() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
        
        func fetchNearbyPlaces() async {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "en.wikipedia.org"
            components.path = "/w/api.php"
            components.queryItems = [
                URLQueryItem(name: "ggscoord", value: "\(location.coordinate.latitude)|\(location.coordinate.longitude)"),
                URLQueryItem(name: "action", value: "query"),
                URLQueryItem(name: "prop", value: "coordinates|pageimages|pageterms"),
                URLQueryItem(name: "colimit", value: "50"),
                URLQueryItem(name: "piprop", value: "thumbnail"),
                URLQueryItem(name: "pithumbsize", value: "500"),
                URLQueryItem(name: "pilimit", value: "50"),
                URLQueryItem(name: "wbptterms", value: "description"),
                URLQueryItem(name: "generator", value: "geosearch"),
                URLQueryItem(name: "ggsradius", value: "10000"),
                URLQueryItem(name: "ggslimit", value: "50"),
                URLQueryItem(name: "format", value: "json")
            ]
            
            guard let url: URL = components.url else {
                print("Bad URL.")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}
