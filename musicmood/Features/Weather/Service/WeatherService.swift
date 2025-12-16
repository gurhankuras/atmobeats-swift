import Foundation

final class WeatherService: WeatherProvider {
    private let networkService: NetworkService

    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }

    func getWeather(
        latitude: Double,
        longitude: Double,
        completion: @escaping (Result<WeatherResponse, Error>) -> Void
    ) {
        let queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude))
        ]

        networkService.request(
            endpoint: "/weather",
            method: .post,
            queryItems: queryItems,
            completion: completion
        )
    }

    func getWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        let queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude))
        ]

        return try await networkService.request(
            endpoint: "/weather",
            method: .post,
            queryItems: queryItems
        )
    }
}
