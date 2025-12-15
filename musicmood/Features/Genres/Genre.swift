//
//  Genre.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

struct Genre: Decodable, Hashable, Identifiable {
    let id: Int
    let key: String
    let seed: String
    let name: String
    let description: String
}
