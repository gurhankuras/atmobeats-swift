//
//  GenreService.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

final class GenreService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func getGenres() async throws -> [Genre] {
        return try await networkService.request(
            endpoint: "/genre",
            method: .get
        )
    }
}
