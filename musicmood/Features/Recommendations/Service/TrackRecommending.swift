//
//  TrackRecommending.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

import Foundation

protocol TrackRecommending {
    func getRecommendations(
        for request: MusicRecommendationRequest,
        completion: @escaping (Result<[TrackRecommendation], Error>) -> Void
    )
}
