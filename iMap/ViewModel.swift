//
//  ViewModel.swift
//  iMap
//
//  Created by A.f. Adib on 12/27/23.
//

import Foundation
import MapKit

extension ContentView {
    @MainActor class ViewModel : ObservableObject {
        
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        @Published var locations : [Location]
        
        @Published var selectedPlace : Location?
        
        let savePath = FileManager.doccumentsDirectory.appendingPathComponent("Saved palces")
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        
        func addLocation() {
            let newLocation = Location(id: UUID(), descripton: "", name: "New Location", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            
            locations.append(newLocation)
            save()
        }
        
        
        func update(location: Location) {
            
            guard let selectedPlace = selectedPlace else {
                return
            }

            if let indexOfLoc = locations.firstIndex(of: selectedPlace) {
               locations[indexOfLoc] = location
               save()
            }
        }
    }
}
