//
//  ArtistsView.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import SwiftUI

struct ArtistsView: View {
    @FocusState private var isSearchFocused: Bool
    @EnvironmentObject var router: Router

    @EnvironmentObject var artistsViewModel: ArtistSearchViewModel
    
    var body: some View {
        ZStack {
            LinearGradient.primary.ignoresSafeArea()
            VStack {
                ViewTitle("artists.title")
                    .overlay(alignment: .topTrailing) {
                        ImageButton(systemName: "star.fill") {
                            router.push(.favoriteArtists)
                        }
                    }
                searchField
                    

                if artistsViewModel.isQueryHasLessThanThreeCharacters {
                    minimumCharactersWarning
                }

                selectedArtistsList
                    .padding(.horizontal, 10)
                    .padding(.vertical)
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .bottom) {
                        nextButton
                    }
                    .overlay(alignment: .top) {
                        dropdownView
                    }
                    .animation(
                        .spring(response: 0.25, dampingFraction: 0.85),
                        value: artistsViewModel.searchText.isEmpty
                    )
                    .animation(
                        .spring(response: 0.3, dampingFraction: 0.85),
                        value: artistsViewModel.artists.count
                    )
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
    }

    func onRemove() {
        print(artistsViewModel.artists)
    }

    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 12)
                .contentShape(Rectangle())
                .onTapGesture {
                    isSearchFocused = true
                }
            TextField(
                "artists.search.field.placeholder",
                text: $artistsViewModel.searchText
            )
            .autocorrectionDisabled()
            .focused($isSearchFocused)
            .padding(.vertical, 10)
            .padding(.leading, 4)
            .overlay(alignment: .trailing) {
                VStack {
                    if !artistsViewModel.searchText.isEmpty {
                        Button {
                            artistsViewModel.searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .tint(.gray)
                                .padding(15)
                        }
                        .transition(.opacity)
                    }
                }
                .animation(
                    .easeIn,
                    value: artistsViewModel.searchText.isEmpty
                )
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(
                    color: .black.opacity(0.1),
                    radius: 4,
                    x: 0,
                    y: 2
                )
        )
        .padding(.horizontal)
    }

    private var minimumCharactersWarning: some View {
        Text("artists.search.minimum_characters_warning")
            .font(.footnote)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .transition(
                .opacity
                    .combined(with: .move(edge: .top))
            )
    }

    private var selectedArtistsList: some View {
        ScrollView {
            LazyVStack {
                ForEach($artistsViewModel.selectedArtists, id: \.id) {
                    $artist in
                    ArtistRow(
                        artist: artist,
                        isSelected: true,
                        onRemove: {
                            artistsViewModel.removeFromSelected(artist)
                        },
                        onTap: nil
                    )
                }
            }
        }
    }

    @ViewBuilder
    private var dropdownView: some View {
        let trimmedQuery = artistsViewModel.searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let queryLength = trimmedQuery.count

        // ✅ Sonuçlar varsa dropdown liste
        if queryLength >= 3 && !artistsViewModel.artists.isEmpty {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach($artistsViewModel.artists, id: \.id) {
                        $artist in
                        ArtistRow(
                            artist: artist,
                            isSelected: artistsViewModel
                                .selectedArtists.contains {
                                    $0.id == artist.id
                                },
                            onTap: {
                                artistsViewModel.toggleSelection(
                                    for: artist
                                )
                                isSearchFocused = false
                            }
                        )
                    }
                }
            }
            .background(.white)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 16,
                    style: .continuous
                )
            )
            .shadow(radius: 8)
            .padding(.horizontal)
            .transition(
                .opacity
            )

            // ✅ 3+ karakter var ama sonuç yoksa “No results”
        } else if queryLength >= 3
            && artistsViewModel.artists.isEmpty
        {
            Text("artists.search.no_found")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 16,
                        style: .continuous
                    )
                )
                .padding(.horizontal)
                .transition(
                    .opacity
                )
        }
    }

    private var nextButton: some View {
        Button {
            artistsViewModel.selectionCompleted()
            router.push(.recommendations)
        } label: {
            Text("artists.next_button")
        }
        .longButtonStyle(isDisabled: artistsViewModel.selectedArtists.isEmpty)
        .padding()
    }

}


struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView()
            .withPreviewDependencies()
    }
}
