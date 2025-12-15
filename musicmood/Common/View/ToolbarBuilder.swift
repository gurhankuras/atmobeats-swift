//
//  ToolbarBuilder.swift
//  musicmood
//
//  Created by Gurhan on 12/15/25.
//

import SwiftUI

enum ToolbarBuilder {
    static func backButton(_ dismiss: @escaping () -> Void)
        -> some ToolbarContent
    {
        return ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
        }
    }
}
