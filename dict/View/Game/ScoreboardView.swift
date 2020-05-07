//
//  ScoreboardView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/12/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct ScoreboardView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var gamePlay: GamePlay
    @State private var dim = false
    
    var animation: Animation {
        Animation.interpolatingSpring(mass: 1, stiffness: 80, damping: 10, initialVelocity: 0)
    }
    
    var body: some View {
        let totalScore = self.gamePlay.correctAnswers + self.gamePlay.wrongAnswers
        let score = Float(self.gamePlay.correctAnswers) / Float(totalScore)
        let winGame = score > 0.6
        return VStack {
            Text(winGame ? "Congrats!" : "Whoops!")
                .font(.system(size: 26, weight: .bold))
                .padding(.all)
                .frame(width: 240)
            
            Image(systemName: winGame ? "checkmark.seal.fill" : "xmark.seal.fill")
                .font(.system(size: 46, weight: .medium))
            
            Text("Score:")
                .padding(.top)
            
            Text(String(self.gamePlay.correctAnswers) + "/" + String(totalScore))
                .font(.system(size: 32, weight: .medium))
                .padding(.bottom)
            
            Button(action: {
                self.gamePlay.stop()
            }) {
                VStack {
                    Text("Restart the game")
                        .frame(width: 160, height: 40)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.firstColor)
                }
                .background(Color("Gray"))
                .cornerRadius(5)
            }.padding(.bottom, 25)
        }
        .frame(width: 280)
        .background(winGame ? Color("Success") : Color("Failure"))
        .cornerRadius(40)
        .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.white, lineWidth: 4))
        .shadow(radius: 20, x: 0, y: 20)
        .foregroundColor(Color("Gray"))
        .opacity(dim ? 1.0 : 0.5)
        .offset(y: dim ? 0 : 120)
        .animation(self.animation)
        .onAppear {
            withAnimation(.easeOut(duration: 0.4)) {
                self.dim.toggle()
            }
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        let gs = GamePlay()
        return ScoreboardView().environmentObject(gs)
    }
}
