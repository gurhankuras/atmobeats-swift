//
//  LongButtonStyle.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import SwiftUI

struct LongButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(
                EdgeInsets(
                    top: 12,
                    leading: 20,
                    bottom: 12,
                    trailing: 20
                )
            )
            .foregroundStyle(.white)
            .font(.title3.weight(.medium))
            .frame(maxWidth: .infinity)
            .background(
                (configuration.isPressed
                    ? Color(red: 0.85, green: 0.10, blue: 0.10)
.opacity(0.7)
                    : Color(red: 0.85, green: 0.10, blue: 0.10)
),
                in: Capsule()
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
