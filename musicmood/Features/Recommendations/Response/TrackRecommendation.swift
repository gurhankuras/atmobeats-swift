//
//  TrackRecommendation.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

/**
 {
   "title": "ocean eyes",
   "artist": "Billie Eilish",
   "reason": null,
   "matchScore": 0,
   "spotifyUrl": "https://open.spotify.com/track/2uIX8YMNjGMD7441kqyyNU",
   "spotifyUri": "spotify:track:2uIX8YMNjGMD7441kqyyNU",
   "albumImageUrl": "https://i.scdn.co/image/ab67616d0000b2732cafcdd985630d72594ecc49"
 },
 */

struct TrackRecommendation: Decodable {
    let title: String
    let artist: String
    let reason: String?
    let matchScore: Int?
    let spotifyUrl: String?
    let spotifyUri: String
    let albumImageUrl: String
    let previewUrl: String?

    static var stub: TrackRecommendation {
        return TrackRecommendation(
            title: "ocean eyes",
            artist: "Billie Eilish",
            reason: nil,
            matchScore: 90,
            spotifyUrl: "https://open.spotify.com/track/2uIX8YMNjGMD7441kqyyNU",
            spotifyUri: "spotify:track:2uIX8YMNjGMD7441kqyyNU",
            albumImageUrl:
                "https://i.scdn.co/image/ab67616d0000b2732cafcdd985630d72594ecc49",
            previewUrl: nil
        )
    }

}
