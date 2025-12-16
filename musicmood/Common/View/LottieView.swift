//
//  LottieView.swift
//  musicmood
//
//  Created by Gurhan on 12/8/25.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let name: String
    var loopMode: LottieLoopMode = .loop
    var animationSpeed: CGFloat = 1.0

    func makeUIView(context: Context) -> some UIView {
        let container = UIView()

        let animationView = LottieAnimationView(name: name)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.play()

        container.addSubview(animationView)

        // frame'e uyması için AutoLayout
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(
                equalTo: container.leadingAnchor
            ),
            animationView.trailingAnchor.constraint(
                equalTo: container.trailingAnchor
            ),
            animationView.topAnchor.constraint(equalTo: container.topAnchor),
            animationView.bottomAnchor.constraint(
                equalTo: container.bottomAnchor
            )
        ])

        return container
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
