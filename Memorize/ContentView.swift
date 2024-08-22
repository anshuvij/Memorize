//
//  ContentView.swift
//  Memorize
//
//  Created by Anshu Vij on 22/08/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "😈", "🕷️"]
    
    var body: some View {
        HStack {
            ForEach(emojis, id: \.self) { emoji in
                CardView(content: emoji)
            }
        }
        .foregroundStyle(.orange)
        .padding()
        
    }
}

struct CardView : View {
    let content : String
    @State var isFaceUp : Bool = true
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                   base.foregroundStyle(.white)
                   base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
