//
//  MemoryGameModel.swift
//  memoizes
//
//  Created by Kennedy Ferreira da Silva Ribeiro on 14/08/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  
  private var facedCardIndex: Int?
  private var score = 0
  private var clicks = 0
  private var restPairs = 0
  
  
  
  mutating func choose(_ card: Card) {
    if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }),
        !cards[choosenIndex].isFaceUp,
        !cards[choosenIndex].isMatched
    {
      if let potentialMatch = facedCardIndex {
        if cards[choosenIndex].content == cards[potentialMatch].content {
          score = score + 1;
          restPairs = restPairs - 1;
          cards[choosenIndex].isMatched = true;
          cards[potentialMatch].isMatched = true;
        }
        facedCardIndex = nil
      } else {
        for index in cards.indices {
          cards[index].isFaceUp = false;
        }
        facedCardIndex = choosenIndex
      }
      
      if restPairs == 0 {
        print("acabou o jogo")
        reset()
      }
      
      cards[choosenIndex].isFaceUp.toggle()
      clicks += 1
    }
    print("pontuacao é \(score)")
    print("clicks \(clicks)")
  }
  
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = [];
    
    for pairIndex in 0..<numberOfPairsOfCards  {
      let content: CardContent = createCardContent(pairIndex);
      
      cards.append(Card(id: "\(pairIndex+1)a", content: content ))
      cards.append(Card(id: "\(pairIndex+1)b", content: content))
    }
    restPairs = numberOfPairsOfCards;
    shuffle()
  }
  
  mutating func shuffle() {
    cards.shuffle();
  }
  
  mutating func reset() {
    for index in cards.indices {
      cards[index].isFaceUp = false;
      cards[index].isMatched = false;
    }
    restPairs = cards.count / 2;
    shuffle()
  }
  


  struct Card: Identifiable, Equatable, CustomDebugStringConvertible {
    var debugDescription: String {
      return "\(id): \(content) \(isFaceUp ?"up" : "down") \(isMatched ? "matched" : "")"
    }
    let id: String
    
    var isFaceUp = false
    var isMatched = false
    let content: CardContent
  }
}
