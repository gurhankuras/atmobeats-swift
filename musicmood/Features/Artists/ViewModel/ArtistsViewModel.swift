import Combine
import Foundation
import UIKit

class ArtistSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedArtists: [Artist] = []

    @Published var artists: [Artist] = []

    private var cancellables = Set<AnyCancellable>()
    private let artistProvider: ArtistProvider
    private let artistStore: ArtistCoreDataStore

    init(artistProvider: ArtistProvider, artistStore: ArtistCoreDataStore) {
        self.artistProvider = artistProvider
        self.artistStore = artistStore
        bindSearch()
    }

    /// Callback tabanlı fonksiyonu Combine publisher'a çeviriyoruz
    private func artistPublisher(for query: String) -> AnyPublisher<
        [Artist], Never
    > {
        Future<[Artist], Error> { [artistProvider] promise in
            artistProvider.getArtists(query: query) { result in
                switch result {
                case let .success(artists):
                    promise(.success(artists))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
        // Burada Error'ı yiyip Failure tipini Never'e çeviriyoruz
        .replaceError(with: [])
        .eraseToAnyPublisher()
    }

    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { query in
                query.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
            }
            // switchToLatest için: Publisher'ın Publisher'ını döndürüyoruz
            .map { [weak self] query -> AnyPublisher<[Artist], Never> in
                guard
                    let self,
                    !query.trimmingCharacters(in: .whitespacesAndNewlines)
                    .isEmpty
                else {
                    // boş query'de boş dizi dönen basit bir publisher
                    return Just([])
                        .eraseToAnyPublisher()
                }

                return artistPublisher(for: query)
            }
            .switchToLatest() // En son gelen query için istek çalışır
            .receive(on: DispatchQueue.main)
            .sink { [weak self] artists in
                self?.artists = artists
            }
            .store(in: &cancellables)
    }

    func toggleSelection(for artist: Artist) {
        if let index = selectedArtists.firstIndex(where: { $0.id == artist.id }) {
            selectedArtists.remove(at: index)
        } else {
            selectedArtists.append(artist)
        }

        searchText = ""
        artists = []
    }

    func selectionCompleted() {
        for artist in selectedArtists {
            artistStore.saveArtist(artist: artist)
        }
    }

    func removeFromSelected(_ artist: Artist) {
        selectedArtists.removeAll { $0.id == artist.id }
    }

    var isQueryHasLessThanThreeCharacters: Bool {
        let q =
            searchText
                .trimmingCharacters(in: .whitespacesAndNewlines)
        return !q.isEmpty
            && q
            .count < 3
    }

    func isSelected(artist: Artist) -> Bool {
        selectedArtists.contains {
            $0.id == artist.id
        }
    }

    func reset() {
        selectedArtists = []
        artists = []
        searchText = ""
    }
}
