//
//  ContentView.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @StateObject var router = DependencyFactory.buildRouter()

    var body: some View {
        NavigationStack(path: $router.paths) {
            SplashView()
                .navigationBarBackButtonHidden(true)
                .navigationDestination(
                    for: Route.self,
                    destination: { route in
                        RouteBuilder.destination(for: route)
                    }
                )
        }
        .environmentObject(router)
        .dismissKeyboardOnTap()
        .onOpenURL { url in
            router.handleLink(url)
        }
    }
}

#Preview {
    ContentView()
}
