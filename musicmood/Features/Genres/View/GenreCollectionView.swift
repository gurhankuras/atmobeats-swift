import SwiftUI

// MARK: - Main Genres View
struct GenresCollectionView: View {
    var genres: [Genre]
    @Binding var selectedGenres: Set<Genre>

    var body: some View {
        ScrollView {
            WrapLayout(spacing: 12) {
                ForEach(genres) { genre in
                    GenreChip(
                        genre: genre,
                        isSelected: selectedGenres.contains(where: {
                            $0.id == genre.id
                        }),
                        onTap: {
                            if let existing = selectedGenres.first(where: {
                                $0.id == genre.id
                            }) {
                                selectedGenres.remove(existing)
                            } else {
                                selectedGenres.insert(genre)
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
