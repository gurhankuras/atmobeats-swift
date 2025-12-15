//
//  URL+isDeepLink.swift
//  musicmood
//
//  Created by Gurhan on 12/15/25.
//

import Foundation
extension URL {
    var isDeepLink: Bool {
        return scheme == "atmobeats"
    }
    
    var isUniversalLink: Bool {
        return scheme == "https"
    }
}
