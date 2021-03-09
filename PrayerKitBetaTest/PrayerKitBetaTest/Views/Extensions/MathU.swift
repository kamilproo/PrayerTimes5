//
//  MathU.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import Foundation

internal extension Double {

    func normalizedToScale(_ max: Double) -> Double {
        return self - (max * (floor(self / max)))
    }
}
