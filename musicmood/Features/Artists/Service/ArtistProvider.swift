//
//  ArtistProvider.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

protocol ArtistProvider {
    func getArtists(
        query: String,
        completion: @escaping (Result<[Artist], Error>) -> Void
    )
}
