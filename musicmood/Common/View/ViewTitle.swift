//
//  ViewTitle.swift
//  musicmood
//
//  Created by Gurhan on 12/9/25.
//

import SwiftUI

struct ViewTitle: View {
    let key: LocalizedStringKey

    init(_ key: LocalizedStringKey) {
        self.key = key
    }

    var body: some View {
        Text(key)
            .font(
                .custom(
                    "Helvetica Neue",
                    size: 42,
                    relativeTo: .largeTitle
                )
            )
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            .fontWeight(.semibold)
            .foregroundStyle(.black)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .minimumScaleFactor(0.6)
            .padding(30)
    }
}
