//
//  EmojiMemoryGame.swift
//  memoizes
//
//  Created by Kennedy Ferreira da Silva Ribeiro on 15/08/23.
//



import SwiftUI

class EmojiMemoryGame: ObservableObject {
  typealias Card = MemoryGame<String>.Card
  static let emojis = ["🥹","🗿","💼", "🪥", "👨🏽‍💻"]
  public var ButtonText = "Shuffle"
  
  
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 4, createCardContent: { index in
        return emojis[index]
      })
  }
  
  @Published private var model = createMemoryGame()
  
  var cards: Array<Card> {
    return model.cards
  }
  
  // MARK: - Intent(s)
  
  func choose(_ card: Card) {
    model.choose(card);
  }
  
  func shuffle() {
    model.shuffle()
    if ButtonText == "Shuffle"  {
      ButtonText = "Shuff"
    } else {
      ButtonText = "Shuffle"
    }
  }
  
  func reset() {
    model.reset()
  }
}

