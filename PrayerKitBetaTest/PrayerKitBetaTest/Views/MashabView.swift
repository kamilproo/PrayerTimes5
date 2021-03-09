//
//  MashabView.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import SwiftUI

struct MashabView: View {
    @StateObject var noti = NotificationViewModel()
    @ObservedObject var model: PrayerTimeViewModel
    @Environment(\.presentationMode) var presetationMode
    var body: some View {
        List(Madhab.allCases, id: \.self) { item in
            Button(action: {
                self.model.objectWillChange.send()
                self.presetationMode.wrappedValue.dismiss()
                self.model.mashab = item
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
                    Text("\(item.names)").font(Font.custom("Montserrat-Medium", size: 15))
                    Spacer()
                    if self.model.mashab == item {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}


