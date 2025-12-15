//
//  View+withPreviewDependencies.swift
//  musicmood
//
//  Created by Gurhan on 12/14/25.
//

import SwiftUI

#if DEBUG
extension View {
    func withPreviewDependencies() -> some View {
        self
            .environmentObject(DependencyFactory.buildArtistSearchViewModel())
            .environmentObject(DependencyFactory.buildGenresViewModel())
            .environmentObject(DependencyFactory.buildWeatherViewModel())
            .environmentObject(
                DependencyFactory.buildRecommendationsViewModel()
            )
    }
}
#endif

