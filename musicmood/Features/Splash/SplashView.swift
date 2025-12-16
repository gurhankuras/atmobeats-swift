//
//  SplashView.swift
//  musicmood
//
//  Created by Gurhan on 12/9/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.48, blue: 0.12)
                .ignoresSafeArea()

            Image("AstronautHead")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
        }
        .task {
            try? await Task.sleep(nanoseconds: 1000000000)
            router.push(.weather)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(DependencyFactory.buildRouter())
    }
}
