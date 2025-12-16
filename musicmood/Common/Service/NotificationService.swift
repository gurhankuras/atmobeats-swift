//
//  NotificationService.swift
//  musicmood
//
//  Created by Gurhan on 12/15/25.
//

import UserNotifications

class NotificationService {
    let notificationCenter: UNUserNotificationCenter
    init(notificationCenter: UNUserNotificationCenter) {
        self.notificationCenter = notificationCenter
    }

    func ensureNotificationPermission(
        completion: @escaping (Bool) -> Void
    ) {
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                completion(true)
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .badge, .sound]
                ) { granted, _ in
                    completion(granted)
                }
            case .denied:
                completion(false)
            default:
                completion(false)
            }
        }
    }
}
