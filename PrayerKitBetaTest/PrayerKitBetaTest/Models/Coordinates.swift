//
//  Coordinates.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import Foundation

public struct Coordinates: Codable, Equatable {
    let latitude: Double
    let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var latitudeAngle: Angle {
        return Angle(latitude)
    }
    
    var longitudeAngle: Angle {
        return Angle(longitude)
    }
}
