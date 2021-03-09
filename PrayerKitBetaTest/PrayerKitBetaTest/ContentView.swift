//
//  ContentView.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().isHidden = true
        
    }
    @StateObject var noty = NotificationViewModel()
    @StateObject var models = PrayerTimeViewModel()
    @State var isPrayer = true
    @AppStorage("status") var status = false
    @AppStorage("home") var home = false
    @State var times: PrayerTimes?
    @StateObject var model = LocationManager()
    @State var selected = "home"
    @State var prayer: PrayerTimes?
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
        TabView(selection: $selected) {
            Home(models: model).environmentObject(models)
                .tag("home")
                .padding(.top)
                .padding(.vertical)
                .padding(.horizontal)
            Text("hommmmmy").tag("homes")
            QiblaView().tag("homess")
            SettingView(model: models, noty: noty)
                
                .tag("homesss")
        }
            HStack(spacing: 0) {
                TapButton(title: "home", image: "house.circle", selected: $selected)
                Spacer(minLength: 0)
                TapButton(title: "homess", image: "safari", selected: $selected)
                Spacer(minLength: 0)
                TapButton(title: "homesss", image: "gearshape", selected: $selected)
                
            }.edgesIgnoringSafeArea(.bottom)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.black)
            .clipShape(Capsule())
            .shadow(color: .gray, radius: 5)
           .padding(.horizontal, 15)
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}


struct TapButton: View {
    var title: String
    var image: String
    @Binding var selected: String
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {selected = title}
        }) {
            HStack(spacing: 20) {
            Image(systemName: "\(image)")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color(selected == title ? .white : .gray))
            
           
            }.edgesIgnoringSafeArea(.all)
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
    }
}
