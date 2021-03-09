//
//  PrayerKitBetaTestApp.swift
//  PrayerKitBetaTest
//
//  Created by Камиль Зиязетдинов on 06.02.2021.
//

import SwiftUI

@main
struct PrayerKitBetaTestApp: App {
    @AppStorage("isDark") var isDark = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDark ? .dark : .light)
                .accentColor(.primary)
        }
    }
}

extension View {
    func onAppEnterBackground(_ handler: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            handler()
        }
    }
    
    func onAppBecomeActive(_ handler: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            handler()
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
      func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.banner, .sound, .badge])
      }
}
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            UNUserNotificationCenter.current().delegate = self
            print(">> your code here !!")
            return true
        }
        
    }
