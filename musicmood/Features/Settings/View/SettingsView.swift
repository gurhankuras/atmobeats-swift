//
//  SettingsView.swift
//  musicmood
//
//  Created by Gurhan on 12/15/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var notificationPermission: NotificationPermissionState
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            LinearGradient.primary.ignoresSafeArea()
            VStack {
                if notificationPermission.shouldShowSettingsAlert {
                    Button {
                        openAppSettings()
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "bell.fill")
                                .imageScale(.large)
                            Text(
                                "Notifications are disabled. Tap here to go to Settings and turn them on"
                            )
                            .lineSpacing(4)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.light)
                        }
                        .tint(.primary)
                        .padding()
                        .padding(.vertical, 8)
                        .background(
                            .ultraThinMaterial,
                            in: RoundedRectangle(cornerRadius: 12)
                        )
                        .padding()
                    }
                    .transition(.opacity.animation(.easeIn))
                }
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.visible, for: .navigationBar)
            .toolbar {
                ToolbarBuilder.backButton {
                    dismiss()
                }
            }
        }
    }

    private func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(url)
    }
}

struct SettingsViewPreview: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(
                NotificationPermissionState(shouldShowSettingsAlert: true)
            )
    }
}
