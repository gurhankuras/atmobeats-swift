//
//  GenreViewModel.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

import Combine

class GenreViewModel: ObservableObject {
    let service: GenreService

    @Published var genresState: AsyncState<[Genre], Error> = .idle

    @Published var genres: [Genre] = []

    @Published var selectedGenres: Set<Genre> = []

    init(service: GenreService) {
        self.service = service
    }

    @MainActor
    func fetchGenres() async {
        genresState = .loading
        do {
            let items = try await service.getGenres()
            genresState = .success(items)
            genres = items
        } catch {
            genresState = .error(error)
            print(error)
        }
    }

    func reset() {
        genres = []
        selectedGenres = []
        genresState = .idle
    }
}
