//
//  NavigationRouter.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import Combine
import Foundation
import SwiftUI

class Router: ObservableObject {

    private var routeCallbacks: [String: [String: () -> Void]] = [:]

    init(paths: [Route]) {
        self.paths = paths
    }

    @Published var paths:  [Route]
    @Published var isReady = false

    private var pendingRoute: Route?

    func push(_ route: Route) {
        paths.append(route)
    }

    func setPath(_ routes: [Route]) {
        paths = routes
    }

    func pop() {
        _ = paths.popLast()
    }

    func popToRoot() {
        paths.removeAll()
    }

    func markAsReady() {
        isReady = true

        // Handle pending route if any
        if let pending = pendingRoute {
            pendingRoute = nil
            push(pending)
        }
    }

    func handleLink(_ url: URL) {
        guard let route = Route.from(url: url) else {
            print("❌ Invalid deep link: \(url)")
            return
        }

        if isReady {
            push(route)
        } else {
            pendingRoute = route
        }
    }

}
