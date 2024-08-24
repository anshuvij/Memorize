//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Anshu Vij on 22/08/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
