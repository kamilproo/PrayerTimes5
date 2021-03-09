//
//  CompassMaker.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 23.02.2021.
//

import SwiftUI
struct Compass: View {
    var body: some View{
        GeometryReader { geometry in
            ZStack{
                Circle()
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .foregroundColor(.clear)
                    .overlay(
                        Circle()
                            .stroke(Color.blue)
                )
            }
        }
    }
}


struct CompassMarkerView: View {
    @AppStorage("isDark") var isDark = false
    let marker: Marker
    let compassDegress: Double

    var body: some View {
        VStack {
            // Text(marker.degreeText())
              //      .fontWeight(.light)
                //    .rotationEffect(self.textAngle())
               // .foregroundColor(.black)

            Capsule()
                    .frame(width: self.capsuleWidth(),
                            height: self.capsuleHeight())
                    .foregroundColor(self.capsuleColor())
                    .padding(.bottom, 140)
                .foregroundColor(isDark ? .white : .black)

            Text(marker.label)
                    .fontWeight(.bold)
                
                .padding(.bottom, 50)
                .foregroundColor(isDark ? .white : .black)
        }.rotationEffect(.init(degrees: marker.degrees))
        .animation(.easeIn(duration: 1))
    }
    
    private func capsuleWidth() -> CGFloat {
        return self.marker.degrees == 0 ? 7 : 3
    }
    
    private func capsuleHeight() -> CGFloat {
        return self.marker.degrees == 0 ? 45 : 30
    }
    
    private func capsuleColor() -> Color {
        return self.marker.degrees == 0 ? .red : Color(isDark ? .white : .black)
    }
    
     func textAngle() -> Angle {
        return .init(-self.compassDegress - self.marker.degrees)
    }
}

struct QiblaLine: View {
    @AppStorage("isDark") var isDark = false
    @State var compassDegree: Double? = nil
    var body: some View{
        VStack {
            if compassDegree != nil {
                Image(systemName: "line.diagonal.arrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: -130))
                    .foregroundColor(isDark ? .green : .green)
            
                
               
                .offset(x: -60)
                    .rotationEffect(.init(degrees: compassDegree!))
                    .animation(.easeIn(duration: 1))
            }
        }
    }
}


struct InnerPin: View {
    @AppStorage("isDark") var isDark = false
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 11, height: 11)
                .foregroundColor(isDark ? .white : .black)
            Circle()
                .frame(width: 9, height: 9)
                .foregroundColor(isDark ? .white : .black)
                .overlay(
                    Circle()
                        .stroke(Color(isDark ? .white : .black))
            )
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(.clear)
                .overlay(
                    Circle()
                        .stroke(Color.black)
            )
        }
    }
}




struct LowerNeedle: View {
    private var needleBottom: CGFloat = 5.0
    private var needleLength: CGFloat = 50.0
    @AppStorage("isDark") var isDark = false
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: geometry.size.width / 2 - self.needleBottom , y: geometry.size.height / 2))
                
                path.addLine(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2 + self.needleLength))
                
                path.addLine(to: CGPoint(x: geometry.size.width / 2 + self.needleBottom , y: geometry.size.height / 2))
                
            }.foregroundColor(isDark ? .white : .black)
        }
    }
}



struct QiblaView: View{
    @AppStorage("isDark") var isDark = false
    @ObservedObject var compassHeading: CompassHeading = CompassHeading()
    var body: some View{
        ZStack{
            VStack{
                Text("N")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                Image(systemName: "triangle.fill")
                    
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isDark ? .white : .black)
                ZStack {
                   
                    UpperNeedle()
                    LowerNeedle()
                    InnerPin()
                    ForEach(Marker.markers(), id: \.self) { marker in
                        CompassMarkerView(marker: marker, compassDegress: 0)
                   }
                    QiblaLine(compassDegree: 210)
                }
                .frame(width: 320, height: 320)
                .rotationEffect(.init(degrees: compassHeading.degrees))
                .animation(.easeIn(duration: 1))
                .statusBar(hidden: true)
                
                .padding(.bottom)
                
                Text("* Совместите северную (красную) линию с буквой «N» (красной). Зеленая стрелка указывает направление киблы.")
                    .font(.caption)
                    .fontWeight(.semibold)
               // .padding()
            }.padding()
        }
    }
}


struct UpperNeedle: View {
    private var needleBottom: CGFloat = 5.0
    private var needleLength: CGFloat = 50.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: geometry.size.width / 2 - self.needleBottom , y: geometry.size.height / 2))
                
                path.addLine(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2 - self.needleLength))
                
                path.addLine(to: CGPoint(x: geometry.size.width / 2 + self.needleBottom , y: geometry.size.height / 2))
                
            }.foregroundColor(.red)
            
        }
    }
}





struct Marker: Hashable {
    let degrees: Double
    let label: String

    init(degrees: Double, label: String = "") {
        self.degrees = degrees
        self.label = label
    }

    func degreeText() -> String {
        return String(format: "%.0f", self.degrees)
    }

    static func markers() -> [Marker] {
        return [
            Marker(degrees: 0, label: "S"),
            Marker(degrees: 30),
            Marker(degrees: 60),
            Marker(degrees: 90, label: "W"),
            Marker(degrees: 120),
            Marker(degrees: 150),
            Marker(degrees: 180, label: "N"),
            Marker(degrees: 210),
            Marker(degrees: 240),
            Marker(degrees: 270, label: "E"),
            Marker(degrees: 300),
            Marker(degrees: 330)
        ]
    }
}

