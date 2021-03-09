//
//  CalculationParameters.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import Foundation

public struct CalculationParameters: Codable, Equatable {
    public var method: CalculationMethod = .dubai
    public var fajrAngle: Double
    public var maghribAngle: Double?
    public var ishaAngle: Double
    public var ishaInterval: Minute = 0
    public var madhab: Madhab = .shafi
    public var highLatitudeRule: HighLatitudeRule = .middleOfTheNight
    public var adjustments: PrayerAdjustments = PrayerAdjustments()
    var methodAdjustments: PrayerAdjustments = PrayerAdjustments()

    init(fajrAngle: Double, ishaAngle: Double) {
        self.fajrAngle = fajrAngle
        self.ishaAngle = ishaAngle
    }

    init(fajrAngle: Double, ishaInterval: Minute) {
        self.init(fajrAngle: fajrAngle, ishaAngle: 0)
        self.ishaInterval = ishaInterval
    }

    init(fajrAngle: Double, ishaAngle: Double, method: CalculationMethod) {
        self.init(fajrAngle: fajrAngle, ishaAngle: ishaAngle)
        self.method = method
    }

    init(fajrAngle: Double, ishaInterval: Minute, method: CalculationMethod) {
        self.init(fajrAngle: fajrAngle, ishaInterval: ishaInterval)
        self.method = method
    }
    
    init(fajrAngle: Double, maghribAngle: Double, ishaAngle: Double, method: CalculationMethod) {
        self.init(fajrAngle: fajrAngle, ishaAngle: ishaAngle, method: method)
        self.maghribAngle = maghribAngle
    }

    func nightPortions() -> (fajr: Double, isha: Double) {
        switch self.highLatitudeRule {
        case .middleOfTheNight:
            return (1/2, 1/2)
        case .seventhOfTheNight:
            return (1/7, 1/7)
        case .twilightAngle:
            return (self.fajrAngle / 60, self.ishaAngle / 60)
        }
    }
}
