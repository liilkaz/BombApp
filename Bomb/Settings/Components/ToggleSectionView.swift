//
//  ToggleSectionView.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct ToggleSectionView: View {
    var title: String
    @Binding var toggleValue: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Spacer()
            Toggle(isOn: $toggleValue) {}
        }
        .foregroundStyle(Color.secondaryTextColor)
        .modifiedText(size: 18)
        .tint(.mainBackground)
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.primaryTextColor)
        .cornerRadius(15)
    }
}

struct ToggleSectionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ToggleSectionView(title: "Вибрация", toggleValue: .constant(false))
            ToggleSectionView(title: "Вибрация", toggleValue: .constant(true))
        }
    }
}
