//
//  LottieView.swift
//  Bomb
//
//  Created by Илья Шаповалов on 08.08.2023.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    private let animationView: LottieAnimationView

    let animationName: String
    let animationSpeed: Double
    
    init(_ animationName: String, animationSpeed: Double = 1) {
        self.animationName = animationName
        self.animationSpeed = animationSpeed
        let configuration = LottieConfiguration(renderingEngine: .mainThread)
        self.animationView = .init(configuration: configuration)
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animation = LottieAnimation.named(animationName)
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = animationSpeed
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        animationView.play()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) { }
}


#Preview {
    VStack {
        LottieView("BombAnimation", animationSpeed: 1)
        LottieView("bangAnimation", animationSpeed: 0.5)
    }
}
