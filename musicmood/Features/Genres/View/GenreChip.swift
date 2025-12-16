//
//  GenreChip.swift
//  musicmood
//
//  Created by Gurhan on 12/9/25.
//

import SwiftUI

struct GenreChip: View {
    let genre: Genre
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Text(genre.name)
            .font(.body)
            .padding(.horizontal, 18)
            .padding(.vertical, 8)
            .background(
                isSelected
                    ? Color(red: 0.85, green: 0.10, blue: 0.10)
                    : Color.white.opacity(0.92)
            )
            .foregroundColor(isSelected ? .white : .black)
            .clipShape(Capsule())
            .onTapGesture {
                onTap()
            }
            .animation(.easeOut, value: isSelected)
    }
}
