//
//  Route.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

enum Route: Hashable {
    case weather
    case genres
    case artists
    case recommendations
    case favoriteArtists
    case settings
}

extension Route {
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.weather, .weather),
             (.genres, .genres),
             (.artists, .artists),
             (.recommendations, .recommendations),
             (.favoriteArtists, .favoriteArtists),
             (.settings, .settings):
            true

        default:
            false
        }
    }
}

// MARK: To conform the Route to Hashable so it can be in a NavPath.

extension Route {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .weather:
            hasher.combine(0)
        case .genres:
            hasher.combine(2)
        case .artists:
            hasher.combine(3)
        case .recommendations:
            hasher.combine(5)
        case .favoriteArtists:
            hasher.combine(6)
        case .settings:
            hasher.combine(7)
        }
    }
}
