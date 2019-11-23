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
    @State var showAnswer = false
    @State var dragState = CGSize.zero
    
    var animation: Animation {
        Animation.interpolatingSpring(mass: 1, stiffness: 80, damping: 10, initialVelocity: 0)
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                FlashCardView(showAnswer: self.$showAnswer, word: "Kot", translation: "Answer").offset(y: -30).scaleEffect(0.95)
                FlashCardView(showAnswer: self.$showAnswer, word: "Dog", translation: "Piesel")
                    .offset(x: self.dragState.width, y: self.dragState.height)
                    .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
                    .onTapGesture {
                        print(self.showAnswer)
                        self.showAnswer.toggle()
                }
                .animation(self.animation)
                .gesture(DragGesture()
                .onChanged { value in
                    self.dragState = value.translation
                }
                .onEnded { value in
                    self.dragState = CGSize.zero
                })
            }
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
