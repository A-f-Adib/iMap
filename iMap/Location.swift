//
//  Location.swift
//  iMap
//
//  Created by A.f. Adib on 12/24/23.
//

import Foundation
import CoreLocation

struct Location : Codable, Identifiable, Equatable {
    
    var id : UUID
    var descripton : String
    var name : String
    let latitude : Double
    let longitude : Double
    
    
    var coordinate : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), descripton: "Where Queen lives", name: "Buckingham Palace", latitude: 51.501, longitude: -0.141)
    
    
    static func == (lhs: Location, rhs: Location) ->Bool {
        lhs.id == rhs.id
    }
}
