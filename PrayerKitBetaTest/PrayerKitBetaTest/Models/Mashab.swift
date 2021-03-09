//
//  Mashab.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import Foundation

/* Madhab for determining how Asr is calculated */
public enum Madhab: Int, Codable, CaseIterable {
    
    // Also for Maliki, Hanbali, and Jafari
    case shafi = 1
    
    case hanafi = 2
    
    
    public var names: String {
        switch self {
        case .hanafi:
            return "Ханафитский масхаб"
        case .shafi:
            return "Шафитский, Маликитский, Хабалитский масхабы"
        }
    }

    var shadowLength: Double {
        return Double(self.rawValue)
    }
}
