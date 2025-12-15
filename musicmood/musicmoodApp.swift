//
//  musicmoodApp.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import SwiftUI

@main
struct musicmoodApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) var scenePhase
    @StateObject var locationManager = DependencyFactory.buildWeatherViewModel()
    @StateObject var genresViewModel = DependencyFactory.buildGenresViewModel()
    @StateObject var artistSearchViewModel =
        DependencyFactory.buildArtistSearchViewModel()
    @StateObject var recommendationsViewModel =
        DependencyFactory.buildRecommendationsViewModel()
    @StateObject var favoriteArtistsViewModel =
        DependencyFactory.buildFavoriteArtistsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(genresViewModel)
                .environmentObject(artistSearchViewModel)
                .environmentObject(recommendationsViewModel)
                .environmentObject(favoriteArtistsViewModel)
                .environmentObject(delegate.permissionState)
                .colorScheme(.light)
        }
    }
}
