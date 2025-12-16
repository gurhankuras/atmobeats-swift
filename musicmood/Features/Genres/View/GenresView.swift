//
//  GenresView.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.

import SwiftUI

struct GenresView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var genreViewModel: GenreViewModel

    var body: some View {
        ZStack {
            LinearGradient.primary.ignoresSafeArea()
            VStack(alignment: .leading) {
                ViewTitle("genres.selection.title")
                if case .loading = genreViewModel.genresState {
                    ProgressView()
                        .scaleEffect(1.5)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .center
                        )
                } else {
                    GenresCollectionView(
                        genres: genreViewModel.genres,
                        selectedGenres: $genreViewModel.selectedGenres
                    )
                    .frame(maxHeight: .infinity)
                }
                Spacer()
                Button {
                    router.push(.artists)
                } label: {
                    Text("genres.next_button")
                }
                .longButtonStyle(
                    isDisabled: genreViewModel.selectedGenres.isEmpty
                )
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
        .task {
            await genreViewModel.fetchGenres()
        }
    }
}

struct GenresView_Previews: PreviewProvider {
    static var genreViewModel: GenreViewModel {
        GenreViewModel(service: GenreService())
    }

    static var router: Router {
        Router(paths: [])
    }

    static var previews: some View {
        GenresView()
            .environmentObject(genreViewModel)
            .environmentObject(router)
    }
}
