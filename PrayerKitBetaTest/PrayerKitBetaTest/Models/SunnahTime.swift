//
//  SunnahTime.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import Foundation

public struct SunnahTimes {

    /* The midpoint between Maghrib and Fajr */
    public let middleOfTheNight: Date

    /* The beginning of the last third of the period between Maghrib and Fajr,
     a recommended time to perform Qiyam */
    public let lastThirdOfTheNight: Date

    public init?(from prayerTimes: PrayerTimes) {
        guard let date = Calendar.gregorianUTC.date(from: prayerTimes.date),
            let nextDay = Calendar.gregorianUTC.date(byAdding: .day, value: 1, to: date),
            let nextDayPrayerTimes = PrayerTimes(
                coordinates: prayerTimes.coordinates,
                date: Calendar.gregorianUTC.dateComponents([.year, .month, .day], from: nextDay),
                calculationParameters: prayerTimes.calculationParameters)
            else {
                // unable to determine tomorrow prayer times
                return nil
        }

        let nightDuration = nextDayPrayerTimes.fajr.timeIntervalSince(prayerTimes.maghrib)
        self.middleOfTheNight = prayerTimes.maghrib.addingTimeInterval(nightDuration / 2).roundedMinute()
        self.lastThirdOfTheNight = prayerTimes.maghrib.addingTimeInterval(nightDuration * (2 / 3)).roundedMinute()
    }
}
