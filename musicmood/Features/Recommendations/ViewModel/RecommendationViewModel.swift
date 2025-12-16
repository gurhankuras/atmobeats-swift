//
//  RecommendationViewModel.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

/*
 {
   "temperatureC": 25,
   "weatherDescription": "sunny",
   "genres": [
     "rock"
   ],
   "favoriteArtists": [
     "Billie Eilish"
   ]
 }
  */

import Combine
import Foundation

struct MusicRecommendationRequest: Encodable {
    let temperatureC: Int
    let weatherDescription: String
    let genres: [String]
    let favoriteArtists: [String]
}

final class RecommendationViewModel: ObservableObject {
    let recommender: TrackRecommending
    @Published var recommendationsState: AsyncState<[TrackRecommendation], Error> = .idle
    @Published var tracks: [TrackRecommendation] = []

    init(recommender: TrackRecommending) {
        self.recommender = recommender
    }

    func getRecommendations(
        for request: MusicRecommendationRequest
    ) {
        recommendationsState = .loading

        recommender.getRecommendations(for: request) { result in
            switch result {
            case let .success(recommendations):
                DispatchQueue.main.async { [weak self] in
                    self?.recommendationsState = .success(recommendations)
                    self?.tracks = recommendations
                }
            case let .failure(error):
                DispatchQueue.main.async { [weak self] in
                    self?.recommendationsState = .error(error)
                }
                print("Failed to fetch recommendations: \(error)")
            }
        }
    }

    func reset() {
        recommendationsState = .idle
        tracks = []
    }
}
