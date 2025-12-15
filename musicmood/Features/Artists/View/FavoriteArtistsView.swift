//
//  FavoriteArtistsView.swift
//  musicmood
//
//  Created by Gurhan on 12/14/25.
//

import SwiftUI

struct FavoriteArtistsView: View {
    @EnvironmentObject var artistsViewModel: FavoriteArtistsViewModel
    @EnvironmentObject var artistsSearchViewModel: ArtistSearchViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient.primary.ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    ForEach($artistsViewModel.artists, id: \.id) {
                        $artist in
                        ArtistRow(
                            artist: artist,
                            isSelected: artistsSearchViewModel.isSelected(
                                artist: artist
                            ),
                            onTap: {
                                artistsSearchViewModel.toggleSelection(
                                    for: artist
                                )
                            }
                        )
                        .border(
                            artistsSearchViewModel.isSelected(artist: artist)
                                ? .blue : .clear,
                            width: 1
                        )
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarBuilder.backButton {
                dismiss()
            }
        }
        .task {
            artistsViewModel.fetchFavoriteArtists()
        }
    }
}

struct FavoriteArtists_Previews: PreviewProvider {

    static var previews: some View {
        FavoriteArtistsView()
            .withPreviewDependencies()
            .environmentObject(
                DependencyFactory.buildFavoriteArtistsViewModel(isPreview: true)

            )
    }
}
