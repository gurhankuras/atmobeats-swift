//
//  ArtistRow.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import SwiftUI

struct ArtistRow: View {
    let artist: Artist
    let isSelected: Bool
    let onRemove: (() -> Void)?
    let onTap: (() -> Void)?

    init(
        artist: Artist,
        isSelected: Bool,
        onRemove: (() -> Void)? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.artist = artist
        self.isSelected = isSelected
        self.onRemove = onRemove
        self.onTap = onTap
    }

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: artist.lowestResolutionImageURL) { phase in
                switch phase {
                case .empty:
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            ProgressView()
                        )

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                case .failure:
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                        )

                @unknown default:
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                }
            }
            .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(artist.name)
                    .font(.title3.weight(.medium))
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                    Text("\(artist.popularity)")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(
                    Capsule()
                        .fill(Color.black.opacity(0.06))
                )
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        
        .contentShape(Rectangle())  // tüm satır tıklanabilir alan
        .onTapGesture {
            onTap?()
        }
        .overlay(alignment: .trailing) {
            if let onRemove {
                Button(role: .destructive) {
                    onRemove()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .font(.title3.weight(.semibold))
                        .symbolRenderingMode(.hierarchical)
                        .padding()
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())  // tıklanabilir alanı büyüt
            }
        }
        .padding(2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.25), lineWidth: isSelected ? 2 : 1)
        )
       
        .animation(
            .spring(response: 0.2, dampingFraction: 0.8),
            value: isSelected
        )
       

    }
}

struct ArtistRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ArtistRow(artist: Artist.stub, isSelected: true)
            ArtistRow(artist: Artist.stub, isSelected: false)
        }
        .padding()
        .previewLayout(.sizeThatFits)

    }
}
