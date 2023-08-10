//
//  HelpCategoriesView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import SwiftUI

struct HelpCategoriesView: View {
    
    private struct Configuration {
        static let stackSpacing: CGFloat = 20
        static let bottomPadding: CGFloat = 4
        static let horizontalPadding: CGFloat = 20
        static let cornerSizeView: CGFloat = 24
        static let dragFrameWidth: CGFloat = 68
        static let dragFrameHeight: CGFloat = 3
        static var dragCornerSize: CGFloat {
            dragFrameHeight / 2
        }
        static let textScaleFactor: CGFloat = 0.7
        static let textFrameWidth: CGFloat = 280
        
    }

    @ObservedObject var vm: CategoryViewModel

    let textData: [(text: String, weight: Font.Weight, size: CGFloat)] = [
        ("Правила игры", .bold, 40),
        ("В игре доступно 6 категорий и более 90 вопросов", .bold, 21),
        ("Можно выбрать сразу несколько категорий для игры", .regular, 21)
    ]
    
    var body: some View {
        ZStack {
            BackgroundView(backgroundColor: .mainBackground)
            
            VStack(spacing: Configuration.stackSpacing) {
                
                dragIndicator
                
                ForEach(textData, id: \.text) { data in
                    styledText(
                        text: data.text,
                        weight: data.weight,
                        size: data.size
                    )
                }
                
                StaticCategoryGrid()
                    .padding(.horizontal)
                    .disabled(true)
                
                Spacer()
            }
            .padding(.top)
            .padding(.bottom,Configuration.bottomPadding)
            .padding(.horizontal, Configuration.horizontalPadding)
        }
        .cornerRadius(Configuration.cornerSizeView)
    }
    
    var dragIndicator: some View {
        Rectangle()
            .fill(Color.primaryTextColor)
            .frame(
                width: Configuration.dragFrameWidth,
                height: Configuration.dragFrameHeight
            )
            .cornerRadius(Configuration.dragCornerSize)
    }
}

extension HelpCategoriesView {
    func styledText(text: String, weight: Font.Weight, size: CGFloat) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .foregroundColor(.primaryTextColor)
            .minimumScaleFactor(Configuration.textScaleFactor)
            .font(.system(size: size, weight: weight, design: .rounded))
            .frame(width: Configuration.textFrameWidth, alignment: .center)
    }
}

struct HelpCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCategoriesView(vm: CategoryViewModel())
    }
}
