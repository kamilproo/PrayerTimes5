//
//  PrayerTimeViewModel.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import SwiftUI
import Combine
class PrayerTimeViewModel: ObservableObject {
    @Published var lm = LocationManager()
    @Published var method: CalculationMethod = .dubai {
        didSet {
            UserDefaults.standard.setValue(method.rawValue, forKey: "method")
            getPrayerTime()
            objectWillChange.send()
        }
    }
   
    @Published var mashab: Madhab = .shafi {
        didSet {
            UserDefaults.standard.setValue(mashab.rawValue, forKey: "mashab")
            getPrayerTime()
            objectWillChange.send()
        }
    }
    @Published var cal: CalculationParameters?
    @Published var times: PrayerTimes?
    @Published var currentPrayer: Prayer = .isha
    init() {
               if let rawValue = UserDefaults.standard.string(forKey: "method") {
                self.method = CalculationMethod(rawValue: rawValue) ?? .dubai
               }
        
        if let mashab = UserDefaults.standard.value(forKey: "mashab") {
            self.mashab = Madhab(rawValue: mashab as! Int) ?? .shafi
        }
               
        
              
    }
      
    func getPrayerTime() {
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: lm.location?.latitude ?? 0.0, longitude: lm.location?.longitude ?? 0.0)
        var par = method.params
        par.madhab = mashab
        self.times = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: par)
    }
            
    
    
    
    
    
  
}
