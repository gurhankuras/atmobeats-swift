//
//  RecommendationsView.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import SwiftUI

struct RecommendationsView: View {
    @EnvironmentObject var viewModel: RecommendationViewModel
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @EnvironmentObject var artistsViewModel: ArtistSearchViewModel
    @EnvironmentObject var genresViewModel: GenreViewModel

    @EnvironmentObject var router: Router

    var body: some View {
        ZStack {
            LinearGradient.primary.ignoresSafeArea()
            if viewModel.recommendationsState.isLoading {
                loadingView
            }
            if !viewModel.recommendationsState.isLoading {
                content
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeOut, value: viewModel.recommendationsState.isLoading)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
        .onAppear {
            fetchRecommendations()
        }
    }

    private var loadingView: some View {
        VStack {
            LottieView(name: "gears")
                .frame(width: 200, height: 200)
            Text("recommendation.loading.text")
                .font(.headline.weight(.medium))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .transition(.opacity)
    }

    private var content: some View {
        VStack {
            ViewTitle("recommendation.title")
                .overlay(alignment: .topTrailing) {
                    homeButton
                }
            LottieView(name: "astronaut")
                .frame(width: 150, height: 150)
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.tracks, id: \.spotifyUri) { track in
                        TrackRow(track: track)
                            .padding(.bottom, 10)
                    }
                }
                .padding()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }

    private var homeButton: some View {
        Button {
            genresViewModel.reset()
            artistsViewModel.reset()
            router.setPath([.weather])
            viewModel.reset()
        } label: {
            Image(systemName: "house.fill")
                .tint(.black)
                .padding(12)
                .background(.ultraThinMaterial, in: Circle())
        }
        .padding(.trailing)
    }

    func fetchRecommendations() {
        let weatherDescription = weatherViewModel.weatherResponse?.description
        let genres = genresViewModel.selectedGenres.map(\.name)
        let artists = artistsViewModel.selectedArtists.map(\.name)
        let temperature = weatherViewModel.weatherResponse?.temperature

        guard let temperature = temperature,
            let weatherDescription = weatherDescription
        else { return }

        viewModel.getRecommendations(
            for: MusicRecommendationRequest(
                temperatureC: temperature,
                weatherDescription: weatherDescription,
                genres: genres,
                favoriteArtists: artists
            )
        )
    }
}

struct RecommendationsRecommendationView_Previews: PreviewProvider {

    static var previews: some View {
        RecommendationsView()
            .withPreviewDependencies()
    }
}
