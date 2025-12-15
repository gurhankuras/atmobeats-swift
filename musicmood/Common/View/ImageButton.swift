//
//  ImageButton.swift
//  musicmood
//
//  Created by Gurhan on 12/14/25.
//
import SwiftUI

struct ImageButton: View {
    let systemName: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .tint(.black)
                .padding(12)
                .background(.ultraThinMaterial, in: Circle())
        }
        .padding(.trailing)
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(systemName: "star.fill") {
            
        }
    }
}
