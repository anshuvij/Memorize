//
//  Cardify.swift
//  Memorize
//
//  Created by Anshu Vij on 25/08/24.
//

import SwiftUI

struct Cardify : ViewModifier, Animatable {
    
    init(isFaceUp : Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    var rotation : Double
    
    var animatableData: Double {
        get {return rotation}
        set {rotation = newValue}
    }
    
    var isFaceUp : Bool {
        rotation < 90
    }
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.strokeBorder(lineWidth: 2)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(rotation),
                                  axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
    
}

extension View {
    func cardify(isFaceUp : Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
