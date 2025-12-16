//
//  KeyboardDismissModifier.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

import SwiftUI

struct KeyboardDismissModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle()) // gesture'ın her yerde çalışmasını garantiler
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}

extension View {
    func dismissKeyboardOnTap() -> some View {
        modifier(KeyboardDismissModifier())
    }
}
