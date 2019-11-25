//
//  FlashCardView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 22/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FlashCardView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var gameStatus: GameStatus
    @State private var showAnswer = false
    @State private var goAway = false
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    var word: String
    var translation: String
    
    var animation: Animation {
        Animation.interpolatingSpring(mass: 1, stiffness: 80, damping: 10, initialVelocity: 0)
    }
    
    func textView(text: String, isAnswer: Bool) -> some View {
        Text(text)
            .bold()
            .font(.title)
            .foregroundColor(Color.white)
            .frame(maxWidth: 300)
            .shadow(radius: 10)
            .rotation3DEffect(Angle(degrees: isAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
            .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
            .onTapGesture {
                self.showAnswer.toggle()
        }
        .animation(self.animation)
        .gesture(DragGesture()
        .onChanged { value in
            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: self.showAnswer ? -1 * value.translation.height : value.translation.height + self.newPosition.height)
        }
        .onEnded { value in
            self.currentPosition = CGSize.zero
            self.newPosition = self.currentPosition
        })
    }
    
    var body: some View {
        ZStack {
            self.textView(text: self.translation, isAnswer: true)
                .zIndex(self.showAnswer ? 1 : 0)
            
            Image("rectangle_v2")
                .resizable()
                .cornerRadius(10)
                .frame(width: 320, height: 220)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(self.colorScheme == .light ? Color.white : Color.gray, lineWidth: 4))
                .shadow(radius: 5)
                .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
                .onTapGesture {
                    self.showAnswer.toggle()
            }
            .animation(self.animation)
            .gesture(DragGesture()
            .onChanged { value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: self.showAnswer ? -1 * value.translation.height : value.translation.height + self.newPosition.height)
                if self.currentPosition.width >= 200 || self.currentPosition.width <= -200 {
                    self.goAway = true
                    self.currentPosition.width *= 8
                    
                }
            }
            .onEnded { value in
                if (!self.goAway) {
                    self.currentPosition = CGSize.zero
                    self.newPosition = self.currentPosition
                } else {
                    self.gameStatus.answers += 1
                }
            })
            
            self.textView(text: self.word, isAnswer: false)
                .zIndex(self.showAnswer ? -1 : 0)
        }
    }
}

struct FlashCardView_Previews: PreviewProvider {
    @Binding var param: Bool
    static var previews: some View {
        Game()
    }
}
