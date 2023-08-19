//
//  memoizesApp.swift
//  memoizes
//
//  Created by Kennedy Ferreira da Silva Ribeiro on 12/08/23.
//

import SwiftUI

@main
struct memoizesApp: App {
  private let game = EmojiMemoryGame()
  
  var body: some Scene {
    WindowGroup {
      EmojiMemoryGameView(emojiMemoryGame: game)
    }
  }
}
