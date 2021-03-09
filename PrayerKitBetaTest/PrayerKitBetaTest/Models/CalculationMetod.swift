//
//  CalculationMetod.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import Foundation

import Foundation

/**
  Preset calculation parameters for different regions.

  *Descriptions of the different options*

  **muslimWorldLeague**

  Muslim World League. Standard Fajr time with an angle of 18°. Earlier Isha time with an angle of 17°.

  **egyptian**

  Egyptian General Authority of Survey. Early Fajr time using an angle 19.5° and a slightly earlier Isha time using an angle of 17.5°.

  **karachi**

  University of Islamic Sciences, Karachi. A generally applicable method that uses standard Fajr and Isha angles of 18°.

  **ummAlQura**

  Umm al-Qura University, Makkah. Uses a fixed interval of 90 minutes from maghrib to calculate Isha. And a slightly earlier Fajr time
  with an angle of 18.5°. Note: you should add a +30 minute custom adjustment for Isha during Ramadan.

  **dubai**

  Used in the UAE. Slightly earlier Fajr time and slightly later Isha time with angles of 18.2° for Fajr and Isha in addition to 3 minute
  offsets for sunrise, Dhuhr, Asr, and Maghrib.

  **moonsightingCommittee**

  Method developed by Khalid Shaukat, founder of Moonsighting Committee Worldwide. Uses standard 18° angles for Fajr and Isha in addition
  to seasonal adjustment values. This method automatically applies the 1/7 approximation rule for locations above 55° latitude.
  Recommended for North America and the UK.

  **northAmerica**

  Also known as the ISNA method. Can be used for North America, but the moonsightingCommittee method is preferable. Gives later Fajr times and early
  Isha times with angles of 15°.

  **kuwait**

  Standard Fajr time with an angle of 18°. Slightly earlier Isha time with an angle of 17.5°.

  **qatar**

  Same Isha interval as `ummAlQura` but with the standard Fajr time using an angle of 18°.

  **singapore**

  Used in Singapore, Malaysia, and Indonesia. Early Fajr time with an angle of 20° and standard Isha time with an angle of 18°.

  **tehran**

  Institute of Geophysics, University of Tehran. Early Isha time with an angle of 14°. Slightly later Fajr time with an angle of 17.7°.
  Calculates Maghrib based on the sun reaching an angle of 4.5° below the horizon.

  **turkey**

  An approximation of the Diyanet method used in Turkey. This approximation is less accurate outside the region of Turkey.

  **other**

  Defaults to angles of 0°, should generally be used for making a custom method and setting your own values.

*/
public enum CalculationMethod: String, Codable, CaseIterable {
    case moonsightingCommittee
    case muslimWorldLeague
    case egyptian
    case ummAlQura
    case dubai
    case turkey
    case russia
    case tatarstan
    
    public var names: String {
        switch self {
        
        case .muslimWorldLeague:
            return "Мировая лига мусульман, угол Фаджра 18°, угол Иша 17°"
        case .egyptian:
            return "Египетский, угол Фаджра 19,5°, угол Иша 17,5°"
        case .ummAlQura:
            return "Мекка, Университет Al-Qura, угол Фаджра 18,5°, Иша 90 минут после магриба"
        case .dubai:
            return "Дубай, угол Фаджра 18,2°, угол Иша 18,2°"
        case .turkey:
            return "Турция, угол Фаджра 18°, угол Иша 17°"
        case .russia:
            return "Россия, угол Фаджра 16°, угол Иша 15°"
        case .tatarstan:
            return "Татарстан, угол Фаджра 18°, угол Иша 16°"
        case .moonsightingCommittee:
            return "Татарстан, угол Фаджра 18°, угол Иша 16°"
        }
    }
    

    public var params: CalculationParameters {
        switch(self) {
        
        case .moonsightingCommittee:
            var params = CalculationParameters(fajrAngle: 18, ishaAngle: 17, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 1)
            return params
        
        case .muslimWorldLeague:
            var params = CalculationParameters(fajrAngle: 18, ishaAngle: 17, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 1)
            return params
        case .egyptian:
            var params = CalculationParameters(fajrAngle: 19.5, ishaAngle: 17.5, method: self)
            params.methodAdjustments = PrayerAdjustments(dhuhr: 1)
            return params
        case .ummAlQura:
            return CalculationParameters(fajrAngle: 18.5, ishaInterval: 90, method: self)
        case .dubai:
            var params = CalculationParameters(fajrAngle: 18.2, ishaAngle: 18.2, method: self)
            params.methodAdjustments = PrayerAdjustments(sunrise: -3, dhuhr: 3, asr: 3, maghrib: 3)
            return params
        case .turkey:
            var params = CalculationParameters(fajrAngle: 18, ishaAngle: 17, method: self)
            params.methodAdjustments = PrayerAdjustments(fajr: 0, sunrise: -7, dhuhr: 5, asr: 4, maghrib: 7, isha: 0)
            return params
        case .russia:
            var params = CalculationParameters(fajrAngle: 16, ishaAngle: 15, method: self)
            params.methodAdjustments = PrayerAdjustments(fajr: 0, sunrise: -7, dhuhr: 5, asr: 4, maghrib: 7, isha: 0)
            return params
        case .tatarstan:
            var params = CalculationParameters(fajrAngle: 18, ishaAngle: 16, method: self)
            params.methodAdjustments = PrayerAdjustments(fajr: 0, sunrise: -7, dhuhr: 5, asr: 4, maghrib: 7, isha: 0)
            return params
            
        }
    }
}
