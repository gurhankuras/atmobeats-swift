//
//  MockTrackRecommendationService.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

class MockTrackRecommendationService: TrackRecommending {
    func getRecommendations(
        for request: MusicRecommendationRequest,
        completion: @escaping (Result<[TrackRecommendation], any Error>) -> Void
    ) {
        completion(
            .success([
                .init(
                    title: "Chop Suey!",
                    artist: "System Of A Down",
                    reason: nil,
                    matchScore: 95,
                    spotifyUrl: TrackRecommendation.stub.spotifyUrl,
                    spotifyUri: "1",

                    albumImageUrl: TrackRecommendation.stub.albumImageUrl,
                    previewUrl: nil
                ),
                .init(
                    title: "Stressed Out",
                    artist: "Twenty One Pilots",
                    reason: nil,
                    matchScore: 95,
                    spotifyUrl: TrackRecommendation.stub.spotifyUrl,
                    spotifyUri: "2",

                    albumImageUrl: TrackRecommendation.stub.albumImageUrl,
                    previewUrl: nil
                ),
                .init(
                    title: "Bored",
                    artist: "Billie Eilish",
                    reason: nil,
                    matchScore: 95,
                    spotifyUrl: TrackRecommendation.stub.spotifyUrl,
                    spotifyUri: "3",
                    albumImageUrl: TrackRecommendation.stub.albumImageUrl,
                    previewUrl: nil
                ),
                .init(
                    title: "The Reluctant Heroes",
                    artist: "Sawani Hiroyuki",
                    reason: nil,
                    matchScore: 95,
                    spotifyUrl: TrackRecommendation.stub.spotifyUrl,
                    spotifyUri: "4",
                    albumImageUrl: TrackRecommendation.stub.albumImageUrl,
                    previewUrl: nil
                )

            ])
        )
    }
}
