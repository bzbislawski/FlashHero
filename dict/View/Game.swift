//
//  Game.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Game: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var gameStatus: GameStatus
    
    @FetchRequest(entity: FlashCard.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \FlashCard.createdAt, ascending: true)
    ]) var flashCards: FetchedResults<FlashCard>
    
    var answersCount: Int {
        return self.gameStatus.answers
    }
    
    func offset(index: Int) -> CGSize {
        return CGSize.init(width: 0, height: -(flashCards.count - index - answersCount) * 25)
    }
    
    func scaleEffect(index: Int) -> CGFloat {
        return CGFloat(1 - (0.05 * Double(flashCards.count - index - answersCount)))
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ForEach(0..<flashCards.count) { index in
                    FlashCardView(word: self.flashCards[index].word, translation: self.flashCards[index].translation)
                        .offset(self.offset(index: index))
                        .scaleEffect(self.scaleEffect(index: index))
                        .animation(.spring())
                }
                
                VStack {
                    Spacer()
                    Divider()
                    HStack {
                        ScoreTile(text: "Current score", number: 20)
                        ScoreTile(text: "Highscore", number: 35)
                    }
                }
            }.navigationBarTitle("Swipe game")
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ScoreTile(text: "Current score", number: 20)
            ScoreTile(text: "Highscore", number: 35)
        }
    }
}

struct ScoreTile: View {
    var text: String
    var number: Int
    
    var body: some View {
        
        ZStack {
            Image("rectangle_v2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                
                .frame(width:144, height: 144)
                .background(Color(red:0.56, green:0.56, blue:0.58))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 5))
                .cornerRadius(20)
                .padding(.bottom, 20)
                .padding()
                .shadow(radius: 20, x: 0, y: 20)
                .opacity(0.5)
                .overlay(
                    VStack(alignment: .leading) {
                        Text(self.text)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.top, -50)
                            .padding(.leading, -30)
                        Text("\(self.number)")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.top, -10)
                        
                }.frame(width:144, height: 144))
            
            
            
        }
        
    }
}
