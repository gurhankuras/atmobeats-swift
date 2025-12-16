//
//  URL+isDeepLink+isUniversalLink.swift
//  musicmood
//
//  Created by Gurhan on 12/15/25.
//

import Foundation

extension URL {
    var isDeepLink: Bool {
        scheme == "atmobeats"
    }

    var isUniversalLink: Bool {
        scheme == "https"
    }
}
