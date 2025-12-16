//
//  View+longButtonStyle.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import SwiftUI

extension View {
    func longButtonStyle(isDisabled: Bool = false) -> some View {
        buttonStyle(LongButtonStyle())
            .grayscale(isDisabled ? 1 : 0)
            .opacity(isDisabled ? 0.6 : 1)
            .disabled(isDisabled)
    }
}
