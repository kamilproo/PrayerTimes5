//
//  SettingView.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import SwiftUI
import UserNotifications
struct SettingView: View {
    
    @StateObject var location = LocationManager()
    @State var isNavigationBarHidden: Bool = true
    @ObservedObject var model: PrayerTimeViewModel
    @ObservedObject var noty: NotificationViewModel
    @AppStorage("isDark") var isDark = false
    var body: some View {
    
        NavigationView {
            Form {
                Section(header: Text("Параметры").font(Font.custom("sanF", size: 15))) {
                    NavigationLink(destination: MashabView(model: model), label: {
                        VStack(alignment: .leading) {
                        Text("Масхаб")
                        Text("\(model.mashab.names)")
                            .font(.caption2)
                            .fontWeight(.light)
                        }
                    })
                    NavigationLink(destination: MethodView(model: model),  label: {
                        VStack(alignment: .leading) {
                        Text("Метод расчета")
                            Text("\(model.method.names)")
                            .font(.caption2)
                            .fontWeight(.light)
                        }
                    })
                    
                    
                }
                .edgesIgnoringSafeArea(.all)
                Section(header: Text("Приложение").font(Font.custom("Montserrat-Medium", size: 15))) {
                    HStack {
                    Text("Геопозиция")
                        Spacer()
                    Text("\(location.placemark?.locality ?? "-")")
                        .fontWeight(.light)
                    }
                    HStack {
                    Text("Уведомления")
                    Toggle("", isOn: $noty.sendNotification)
                        .onChange(of: noty.sendNotification) { (value) in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            if noty.sendNotification == true {
                            noty.requestPermission()
                           
                        } else {
                            noty.removeNotifications()
                        }
                        }
                        }
                }
                Section {
                    HStack(spacing: 5) {
                    Text("Тема")
                        Spacer()
                        Spacer()
                        Picker("mode", selection: $isDark) {
                            Text("Светлая").tag(false)
                            Text("Темная").tag(true)
                        }.pickerStyle(SegmentedPickerStyle())
                        .scaleEffect(x: 0.8, y: 0.8)
                    }
                }
                Section {
                    HStack {
                    Text("Версия")
                        Spacer()
                    Text("v1.0")
                        .fontWeight(.light)
                    }
                }
            }
            .navigationBarTitle("") 
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.all)
            }
        
        
    }
}
}

