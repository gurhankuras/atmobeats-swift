//
//  TrackRecommendationService.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

class TrackRecommendationService: TrackRecommending {
    let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    func getRecommendations(
        for request: MusicRecommendationRequest,
        completion: @escaping (Result<[TrackRecommendation], any Error>) -> Void
    ) {
        networkService.request(
            endpoint: "/api/recommendation",
            method: .post,
            body: request,
            completion: completion
        )
    }

}
