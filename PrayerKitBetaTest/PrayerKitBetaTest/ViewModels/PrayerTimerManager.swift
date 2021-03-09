//
//  PrayerTimerManager.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 08.03.2021.
//

import Foundation

final public class PrayerTimerManager {
    
    @Published public private (set) var nextPray: Prayers? = nil
    public private (set) var prayers: [Prayers] = []
    
    private var timer: Timer?
    
    static let shared = PrayerTimerManager()
    
    private init() { }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    public func configure(prayers: [Prayers], timeInterval: TimeInterval = 1) {
        self.prayers = prayers
        
        timer?.invalidate()
        
        guard !prayers.isEmpty else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] (timer) in
            guard let nearestPrayer = self?.prayers.nearest else { return }
            self?.nextPray = nearestPrayer
        })
    }
}
