//
//  PrayerU.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 08.03.2021.
//

import Foundation


public enum Prayers {
    case fajr(Date)
    case sunrise(Date)
    case dhuhr(Date)
    case asr(Date)
    case maghrib(Date)
    case isha(Date)
    
    var date: Date {
        switch self {
        case .fajr(let date):         return date
        case .sunrise(let date):    return date
        case .dhuhr(let date):      return date
        case .asr(let date):        return date
        case .maghrib(let date):    return date
        case .isha(let date):       return date
        }
    }
    
    var name: String {
        switch self {
        case .fajr:     return "fajr"
        case .sunrise:  return "sunrise"
        case .dhuhr:    return "dhuhr"
        case .asr:      return "asr"
        case .maghrib:  return "maghrib"
        case .isha:     return "isha"
        }
    }
}


extension Prayers {
    
    static func make(players: PrayerTimes) -> [Prayers] {
        return [.fajr(players.fajr), .sunrise(players.sunrise),
         .dhuhr(players.dhuhr), .asr(players.asr),
         .maghrib(players.maghrib), .isha(players.isha)]
    }
}


extension Array where Element == Prayers {
    var nearest: Element? {
        self.first(where: { $0.date > Date() })
    }
}
