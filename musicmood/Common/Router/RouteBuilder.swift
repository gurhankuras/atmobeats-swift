//
//  RouteBuilder.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import SwiftUI

@MainActor
enum RouteBuilder {
    @ViewBuilder
    static func destination(for route: Route) -> some View {
        switch route {
        case .weather:
            WeatherView()
        case .genres:
            GenresView()
        case .artists:
            ArtistsView()
        case .recommendations:
            RecommendationsView()
        case .favoriteArtists:
            FavoriteArtistsView()
        case .settings:
            SettingsView()
        }
    }
}
