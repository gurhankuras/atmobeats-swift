//
//  NotificationPermissionState.swift
//  musicmood
//
//  Created by Gurhan on 12/15/25.
//

import Combine
import Foundation
import UIKit
import UserNotifications

final class NotificationPermissionState: ObservableObject {

    @Published var shouldShowSettingsAlert = false

    private var didBecomeActiveObserver: NSObjectProtocol?

    init(shouldShowSettingsAlert: Bool = false) {
        self.shouldShowSettingsAlert = shouldShowSettingsAlert
        didBecomeActiveObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.refresh()
        }
    }

    deinit {
        if let obs = didBecomeActiveObserver {
            NotificationCenter.default.removeObserver(obs)
        }
    }

    private func refresh() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.shouldShowSettingsAlert =
                    (settings.authorizationStatus == .denied)
            }
        }
    }
}
