//
//  Minute.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//


import Foundation

public typealias Minute = Int

internal extension Minute {
    var timeInterval: TimeInterval {
        return TimeInterval(self * 60)
    }
}
