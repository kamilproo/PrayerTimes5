//
//  Home.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import SwiftUI


private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    dateFormatter.amSymbol = ""
    dateFormatter.pmSymbol = ""
    return dateFormatter
}()

struct Home: View {
    @State var currentTime = Date()
    @StateObject var noti = NotificationViewModel()
    @StateObject var models: LocationManager
    @EnvironmentObject var model: PrayerTimeViewModel
    @State var isPrayer = true
   // @State var sheet = false
    @State var currenTime = Date()
    let prayers: [Prayer] = [.fajr, .sunrise, .dhuhr, .asr, .maghrib, .isha]
    @State var prayer: Prayer?
    var body: some View {
        VStack(alignment: .leading) {
          
                      
                
                HStack {
                    Text("Дата: \(Date.hijriDate(Date())())")
                    Spacer(minLength: 0)
                //    Button(action: {
                    //    self.sheet = true
                  //  }) {
                      //  Image(systemName: "calendar").font(.system(size: 40))
                   // }
                }
                ForEach(prayers, id: \.self) { prayer in
                    VStack {
                        ZStack {
                        HStack {
                            Text("\(formattedPrayerName(prayer: prayer))")
                            Spacer(minLength: 0)
                            self.formattedPrayerTime(prayer: prayer, times: model.times)
                        }
                        }
                         
                        }.padding(.top)
                }
        }
        .onAppear {
            DispatchQueue.main.async {
                self.noti.removeNotifications()
                if isPrayer {
                 model.getPrayerTime()
                 self.isPrayer.toggle()
                
             }
          }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if noti.sendNotification == true {
                    noti.scheduleNotification(times: (model.times?.fajr)!)
                    noti.scheduleNotification(times: (model.times?.dhuhr)!)
                    noti.scheduleNotification(times: (model.times?.asr)!)
                    noti.scheduleNotification(times: (model.times?.maghrib)!)
                    noti.scheduleNotification(times: (model.times?.isha)!)
                }
            }
        }
      
        .ignoresSafeArea()
        .padding()
        
    }
    
    
    func isTimeBigger(date: Date) -> Bool {
        let now = Date()
        return now > date && now < date + 180
    }
    
   
    
    func formattedPrayerTime(prayer: Prayer, times: PrayerTimes?) -> some View {
        guard let time = times?.time(for: prayer) else {
            return HStack {
            Text("-")
            Image(systemName: "clock")
                .foregroundColor(.gray)
            }
        }
        return HStack {
            Text("\(time, formatter: dateFormatter)")
            Image(systemName: "clock")
                .foregroundColor(isTimeBigger(date: time) ? .gray : .green)
        }
            
    }
    
    

    func formattedPrayerName(prayer: Prayer) -> Text {
        switch prayer {
        case .fajr:
            return Text("Утренний")
        case .sunrise:
            return Text("Восход")
        case .dhuhr:
            return Text("Полуденнй")
        case .asr:
            return Text("Послеполуденная")
        case .maghrib:
            return Text("Вечерний")
        case .isha:
            return Text("Ночной")
        }
    }
}



