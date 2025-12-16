import Foundation

final class ArtistService: ArtistProvider {
    private let networkService: NetworkService

    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }

    func getArtists(
        query: String,
        completion: @escaping (Result<[Artist], Error>) -> Void
    ) {
        let queryItems = [
            URLQueryItem(name: "query", value: query)
        ]

        networkService.request(
            endpoint: "/spotify",
            method: .get,
            queryItems: queryItems,
            completion: completion
        )
    }

    // Async/await version
    func getArtists(query: String) async throws -> [Artist] {
        let queryItems = [
            URLQueryItem(name: "query", value: query)
        ]

        return try await networkService.request(
            endpoint: "/spotify",
            method: .get,
            queryItems: queryItems
        )
    }
}
