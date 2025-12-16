//
//  FavoriteArtistsViewModel.swift
//  musicmood
//
//  Created by Gurhan on 12/14/25.
//

import Combine
import CoreData

class FavoriteArtistsViewModel: ObservableObject {
    @Published var artists: [Artist] = []

    private let artistStore: ArtistCoreDataStore

    init(artistStore: ArtistCoreDataStore) {
        self.artistStore = artistStore
    }

    func fetchFavoriteArtists() {
        if let fetchedArtists = try? artistStore.getArtistsByCreateDateDescending() {
            artists = fetchedArtists
        }
    }
}
