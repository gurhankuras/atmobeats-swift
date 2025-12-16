//
//  ArtistCoreDataStore.swift
//  musicmood
//
//  Created by Gurhan on 12/14/25.
//

import CoreData

class ArtistCoreDataStore {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveArtist(artist: Artist) {
        context.perform { [weak self] in
            guard let self else { return }
            let entity = ArtistEntity(context: context)
            entity.id = artist.id
            entity.name = artist.name
            entity.imageUrl = artist.lowestResolutionImageURL
            entity.popularity = Int16(artist.popularity)
            entity.createdAt = Date.now
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }

    func getArtistsByCreateDateDescending() throws -> [Artist] {
        let request = ArtistEntity.fetchRequest()
        request.sortDescriptors = [
            .init(keyPath: \ArtistEntity.createdAt, ascending: false)
        ]

        do {
            let entities: [ArtistEntity] = try context.fetch(request)
            return entities.map { artist in
                Artist(
                    id: artist.id ?? UUID().uuidString,
                    images: [
                        ArtistImage(
                            url: artist.imageUrl?.absoluteString ?? "",
                            width: 160,
                            height: 160
                        )
                    ],
                    name: artist.name ?? "Unknown Artist",
                    popularity: Int(artist.popularity)
                )
            }
        } catch {
            throw ArtistCoreDataStoreError.unableToFetchArtists(error: error)
        }
    }
}

enum ArtistCoreDataStoreError: Error, LocalizedError {
    case unableToFetchArtists(error: Error)

    var errorDescription: String? {
        switch self {
        case .unableToFetchArtists:
            "Unable to fetch artists."
        }
    }
}
