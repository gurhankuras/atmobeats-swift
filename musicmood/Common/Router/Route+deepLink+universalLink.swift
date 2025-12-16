//
//  Route+deepLink+universalLink.swift
//  musicmood
//
//  Created by Gurhan on 12/14/25.
//

import Foundation

extension Route {
    static func from(url: URL) -> Route? {
        if url.isDeepLink {
            return fromDeepLink(url: url)
        } else if url.isUniversalLink {
            return fromUniversalLink(url: url)
        }
        return nil
    }

    private static func fromUniversalLink(url: URL) -> Route? {
        let path = url.path

        let pathComponents = path.split(separator: "/").map(String.init)

        switch pathComponents[0] {
        case "favorite-artists":
            return .favoriteArtists
        default:
            return nil
        }
    }

    private static func fromDeepLink(url: URL) -> Route? {
        guard url.isDeepLink else {
            return nil
        }

        guard URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        ) != nil
        else {
            return nil
        }

        // let pathComponents = path.split(separator: "/").map(String.init)

        switch url.host {
        case "weather":
            return .weather

        case "favorite-artists":
            return .favoriteArtists

        default:
            return nil
        }
    }
}
