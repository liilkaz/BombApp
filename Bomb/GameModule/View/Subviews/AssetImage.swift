//
//  AssetImage.swift
//  Bomb
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import SwiftUI

struct AssetImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
    }
    
    init(_ imageName: String) {
        self.imageName = imageName
    }
}

struct BombImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AssetImage("BombImage")
            AssetImage("ExplosionImage")
        }
    }
}
