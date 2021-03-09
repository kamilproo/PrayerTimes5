//
//  onBoarding.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 21.02.2021.
//

import SwiftUI

struct ViewOne: View {
    @StateObject var model = LocationManager()
    var body: some View {
        VStack {
             Text("Acаляму алейкум, добро пожаловать в приложение")
            
            Spacer(minLength: 0)
            ZStack {
            Rectangle()
                .frame(width: 260, height: 50)
                .cornerRadius(30)
                .shadow(color: .gray, radius: 10)
                Button(action: {
                 
                    
                }) {
                Text("Дальше").foregroundColor(.white)
                }
        }
        }.padding()
}
}
struct ViewTwo: View {
    var body: some View {
        Text("")
    }
}

