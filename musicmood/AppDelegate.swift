import FirebaseCore

//
//  AppDelegate.swift
//  musicmood
//
//  Created by Gurhan on 12/15/25.
//
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    let permissionState = NotificationPermissionState()
    private let notificationService: NotificationService = .init(
        notificationCenter: UNUserNotificationCenter.current()
    )

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()

        notificationService.ensureNotificationPermission { granted in
            DispatchQueue.main.async { [weak self] in
                self?.permissionState.shouldShowSettingsAlert = !granted
            }
        }

        return true
    }
}
