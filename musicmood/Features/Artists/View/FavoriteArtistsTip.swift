//
//  ArtistTip.swift
//  musicmood
//
//  Created by Gurhan on 12/14/25.
//
/*

 #if canImport(TipKit)
  import TipKit

  struct FavoriteArtistsTip: Tip, Hashable {
  var title: Text {
  return Text("Select your artist from history")
  }

  var message: Text? {
  return Text("You can select your favorite artists from your previous recommendations.")
  }

  var image: Image? {
  return Image(systemName: "clock")
  }

  var actions: [Action] {
  Action(id: "go_to_favorites", title: "Go to Favorites")
  }

  static let didVisitArtistsViewEvent = Event(id: "didVisitArtistsView")

  var rules: [Rule] {
  [
  #Rule(Self.didVisitArtistsViewEvent) {
  $0.donations.count < 2
  }
  ]
  }

  }
  #endif
  */
