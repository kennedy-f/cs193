//
//  EmojiMemoryGameView.swift
//  memoizes
//
//  Created by Kennedy Ferreira da Silva Ribeiro on 12/08/23.
//

import SwiftUI


struct EmojiMemoryGameView: View {
  @ObservedObject var emojiMemoryGame: EmojiMemoryGame
  
  
  var body: some View {
    VStack {
      ScrollView {
        cards
      }
      .foregroundColor(.red)
      .padding(.horizontal)
      
      Spacer()
      
      HStack {
        Button(action: {
          emojiMemoryGame.shuffle()
        }, label: {
          Text(emojiMemoryGame.ButtonText)
            .animation(.default, value: emojiMemoryGame.ButtonText)
        })
        Spacer()
        Button(action: {
          emojiMemoryGame.reset()
        }, label: {
          Text("Reset")
        })
        
      }
      .padding(.horizontal)
    }
    .font(.largeTitle)
      
  }
  
  var cards: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
      ForEach(emojiMemoryGame.cards) { card in
        CardView(card: card)
          .aspectRatio(2/3, contentMode: .fit)
          .onTapGesture {
            emojiMemoryGame.choose(card)
          }
          .padding(1)
      }
    }
    .animation(.default, value: emojiMemoryGame.cards)
   
  }
  
  func shuffle () {
    emojiMemoryGame.shuffle()
  }
    
}



struct CardView: View {
  let card: EmojiMemoryGame.Card
  
  
  var body: some View {
    ZStack {
      let shape: RoundedRectangle = RoundedRectangle(cornerRadius: 20)
      
      if card.isFaceUp {
        shape.fill(.white).foregroundColor(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(card.content)
      } else if card.isMatched {
        shape.opacity(0)
      } else {
        shape.fill(.red)
      }
    }
  }
 
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let game = EmojiMemoryGame()
    EmojiMemoryGameView(emojiMemoryGame: game)
  }
}


