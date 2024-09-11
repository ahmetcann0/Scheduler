//
//  ScheduleApp.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 27.07.2024.
//

import SwiftUI
import FirebaseCore
import UserNotifications // Bildirimler için eklenmesi gereken kütüphane

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // Bildirim izinleri talep ediliyor
        requestNotificationPermission()
        
        UNUserNotificationCenter.current().delegate = self // Bildirimler için delegate
        return true
    }
    
    // Bildirim izni talebi
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Bildirim izni hatası: \(error.localizedDescription)")
            } else if granted {
                print("Bildirim izni verildi.")
            } else {
                print("Bildirim izni reddedildi.")
            }
        }
    }
}

@main
struct ScheduleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var appState = AppState.shared
    @StateObject private var toDoListItemViewModel = ToDoListItemViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(toDoListItemViewModel)
                .onAppear {
                    scheduleNotification() // Bildirim zamanlama fonksiyonunu tetikleyin
                }
        }
    }
    
    // Yerel bildirim zamanlama
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Planınızı Hatırlatıyoruz!"
        content.body = "Takviminizde bir etkinlik var."
        content.sound = UNNotificationSound.default
        
        // Bildirimi 5 saniye sonra tetikleyin
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Bildirim zamanlama hatası: \(error.localizedDescription)")
            } else {
                print("Bildirim başarıyla zamanlandı!")
            }
        }
    }
}
