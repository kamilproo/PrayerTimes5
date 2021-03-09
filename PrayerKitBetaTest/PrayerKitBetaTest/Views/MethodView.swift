//
//  MethodView.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import SwiftUI

struct MethodView: View {
    @StateObject var noti = NotificationViewModel()
    @ObservedObject var model: PrayerTimeViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        List(CalculationMethod.allCases, id: \.self) { item in
            Button(action: {
                self.model.objectWillChange.send()
                self.presentationMode.wrappedValue.dismiss()
                self.model.method = item
                self.noti.removeNotifications()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if noti.sendNotification == true {
                        noti.scheduleNotification(times: (model.times?.fajr)!)
                        noti.scheduleNotification(times: (model.times?.dhuhr)!)
                        noti.scheduleNotification(times: (model.times?.asr)!)
                        noti.scheduleNotification(times: (model.times?.maghrib)!)
                        noti.scheduleNotification(times: (model.times?.isha)!)
                    }
                }
            }) {
                HStack {
                    Text("\(item.rawValue)")
                    if model.method == item {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}
