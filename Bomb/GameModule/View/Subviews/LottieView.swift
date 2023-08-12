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
    let loopMode: LottieLoopMode
    
    init(
        _ animationName: String,
        loopMode: LottieLoopMode = .playOnce
    ) {
        self.animationName = animationName
        self.loopMode = loopMode
        let configuration = LottieConfiguration(renderingEngine: .mainThread)
        self.animationView = .init(configuration: configuration)
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animation = LottieAnimation.named(animationName)
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
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


struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LottieView("Bomb", loopMode: .loop)
            LottieView("Explosion", loopMode: .loop)
        }
    }
}
