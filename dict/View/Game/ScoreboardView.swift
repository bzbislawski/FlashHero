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
        ZStack {
            BackgroundView()
            VStack{
                HStack {
                    Text("Scoreboard")
                        .foregroundColor(.fontColor)
                        .font(.system(size: 32, weight: .bold))
                    Spacer()
                }
                .frame(maxHeight: 44)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 60)
                
                Spacer()
                
                VStack {
                    Text(self.gamePlay.getScoreboardData().text)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(self.gamePlay.getScoreboardData().color)
                        .padding(.bottom, 20)
                    
                    Image(self.gamePlay.getScoreboardData().image)
                        .frame(height: 150)
                        .padding(.bottom, 20)
                    
                    Text(self.gamePlay.getScoreboardData().sentence)
                        .fixedSize()
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.darkBlue)
                        .padding(.bottom, 20)
                    
                    Text("\(self.gamePlay.correctAnswers) / \(self.gamePlay.getTotalScore()) ")
                        .font(.system(size: 30, weight: .black))
                        .foregroundColor(Color.rgb(r: 62, g: 102, b: 171))
                }
                .padding(.bottom, 15)
                .padding(.top, 25)
                
                Spacer()
                
                Button(action: {
                    self.gamePlay.stop()
                }) {
                    ButtonView(text: "Restart", backgroundColor: Color.lightBlue)
                }.padding(.bottom, 20)
                
                Button(action: {
                    self.gamePlay.stop()
                    self.gamePlay.reset()
                }) {
                    ButtonView(text: "New Game", backgroundColor: Color.darkBlue)
                }
                Spacer()
            }
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        let gs = GamePlay()
        return ScoreboardView()
            .edgesIgnoringSafeArea(.all)
            .environmentObject(gs)
    }
}
