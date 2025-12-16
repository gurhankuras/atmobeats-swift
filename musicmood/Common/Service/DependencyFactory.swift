//
//  DependencyFactory.swift
//  musicmood
//
//  Created by Gurhan on 12/9/25.
//

import CoreLocation

class DependencyFactory {
    static let container = AtmoBeatsPersistentContainer()

    static func buildWeatherViewModel() -> WeatherViewModel {
        WeatherViewModel(
            service: WeatherService(),
            locationManager: CLLocationManager()
        )
    }

    static func buildGenresViewModel() -> GenreViewModel {
        GenreViewModel(service: GenreService())
    }

    static func buildArtistSearchViewModel() -> ArtistSearchViewModel {
        ArtistSearchViewModel(
            artistProvider: ArtistService(),
            artistStore: ArtistCoreDataStore(context: container.writerContext)
        )
    }

    static func buildRecommendationsViewModel() -> RecommendationViewModel {
        RecommendationViewModel(
            recommender: TrackRecommendationService(networkService: .shared)
        )
    }

    static func buildFavoriteArtistsViewModel(isPreview: Bool = false) -> FavoriteArtistsViewModel {
        FavoriteArtistsViewModel(
            artistStore: ArtistCoreDataStore(context: isPreview ? AtmoBeatsPersistentContainer.preview : container
                .writerContext)
        )
    }

    static func buildRouter() -> Router {
        Router(paths: [])
    }
}
