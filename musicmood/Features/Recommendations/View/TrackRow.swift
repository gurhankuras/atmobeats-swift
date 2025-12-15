//
//  TrackRow.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

import SwiftUI

struct TrackRow: View {
    let track: TrackRecommendation
    @Environment(\.openURL) private var openURL

    var body: some View {
        HStack(spacing: 16) {
            albumImage

            VStack(alignment: .leading, spacing: 6) {
                Text(track.title)
                    .font(.headline.weight(.black))

                Text(track.artist)
                    .font(.subheadline.weight(.medium))
            }

            Spacer()

            Button {
                openInSpotify()
            } label: {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
                    .tint(.red)
            }
        }
        .frame(maxHeight: 80)
        .padding(.trailing, 16)  // sadece sağa padding
        .background(
            Color.white.opacity(0.18),  // veya kendi rengin
            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .contextMenu {
            Button {
                openInSpotify()
            } label: {
                Label("Open in Spotify", systemImage: "play")
            }
        }
    }

    private func openInSpotify() {

        if let appURL = URL(string: track.spotifyUri),
            UIApplication.shared.canOpenURL(appURL)
        {
            UIApplication.shared.open(appURL)
        } else if
            let spotifyUrl = track.spotifyUrl,
            let webURL = URL(string: spotifyUrl) {
            UIApplication.shared.open(webURL)
        }
    }

    private var albumImage: some View {
        AsyncImage(
            url: URL(
                string:
                    track.albumImageUrl
            )
        ) { phase in
            switch phase {
            case .empty:
                Color.gray.opacity(0.2)
                    .overlay(ProgressView())

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()  // alanı doldur
                    .clipped()
            case .failure:
                Color.gray.opacity(0.2)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
            @unknown default:
                Color.gray.opacity(0.2)
            }
        }
        .frame(width: 70, height: 70)  // satırı belirleyen kare
        .clipShape(
            RoundedCorner(radius: 12, corners: [.bottomLeft, .topLeft])
        )
    }
}

struct TrackRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TrackRow(track: TrackRecommendation.stub)
        }
        .padding()
        .previewLayout(.sizeThatFits)

    }
}
