//
//  LinearGradient+app.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import SwiftUI

extension LinearGradient {
    static var primary: Self {
        LinearGradient(
            colors: [Color(red: 0.96, green: 0.48, blue: 0.12), .red.opacity(0.7)],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
