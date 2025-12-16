//
//  Artist.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import Foundation

struct Artist: Codable, Identifiable {
    let id: String
    let images: [ArtistImage]
    let name: String
    let popularity: Int

    var lowestResolutionImageURL: URL? {
        if images.isEmpty {
            return nil
        }
        let imgs = images.sorted(by: { $0.width < $1.width })
        return imgs.first?.imageURL
    }

    static var stub: Artist {
        Artist(
            id: "3434",
            images: [
                ArtistImage(
                    url:
                    """
https://static.wikia.nocookie.net/disney/images/c/c0/Taylor_Swift
.jpg/revision/latest/thumbnail/width/360/height/360?cb=20231016171955
""",
                    width: 100,
                    height: 100
                )
            ],
            name: "Taylor Swift",
            popularity: 100
        )
    }
}

struct ArtistImage: Codable {
    let url: String
    let width: Int
    let height: Int

    var imageURL: URL? {
        URL(string: url)
    }
}
