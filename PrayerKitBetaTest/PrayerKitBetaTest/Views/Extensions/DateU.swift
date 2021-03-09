//
//  DateU.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import Foundation

internal extension Date {
    
    func arabianMonth()->String{
            let dateFormatter = DateFormatter()
            dateFormatter.calendar = .init(identifier: .islamicCivil)
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            return dateFormatter.string(from: self)
        }
    
    func hijriDate()->String{
            let calender = Calendar.init(identifier: .islamicCivil)
            let day = calender.component(.day, from: self)
            let month = self.arabianMonth()
            let year = calender.component(.year, from: self)
        return "\(day) \(month), \(year)"
        }

    func roundedMinute() -> Date {
        let cal: Calendar = .gregorianUTC
        var components = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)

        let minute: Double = Double(components.minute ?? 0)
        let second: Double = Double(components.second ?? 0)

        components.minute = Int(minute + round(second/60))
        components.second = 0

        return cal.date(from: components) ?? self
    }
}

internal extension DateComponents {
    
    func settingHour(_ value: Double) -> DateComponents? {
        guard value.isNormal else {
            return nil
        }
        
        let calculatedHours = floor(value)
        let calculatedMinutes = floor((value - calculatedHours) * 60)
        let calculatedSeconds = floor((value - (calculatedHours + calculatedMinutes/60)) * 60 * 60)
        
        var components = self
        components.hour = Int(calculatedHours)
        components.minute = Int(calculatedMinutes)
        components.second = Int(calculatedSeconds)
        
        return components
    }
}

internal extension Calendar {
    
    /// All calculations are done using a gregorian calendar with the UTC timezone
    static let gregorianUTC: Calendar = {
        guard let utc = TimeZone(identifier: "UTC") else {
            fatalError("Unable to instantiate UTC TimeZone.")
        }

        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = utc
        return cal
    }()
}
