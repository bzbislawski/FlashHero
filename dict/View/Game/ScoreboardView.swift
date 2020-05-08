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
                    Text("Well done 🥳")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(Color.rgb(r: 39, g: 130, b: 20))
                        .padding(.bottom, 20)
                    
                    Image("scoreboard_first")
                        .frame(height: 150)
                        .padding(.bottom, 20)
                    
                    Text("""
                        You’ve done very well. You
                        are a total learning beast.
                        The score is amazing!
                        """)
                        .fixedSize()
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.rgb(r: 28, g: 65, b: 116))
                        .padding(.bottom, 20)
                    
                    Text("\(self.gamePlay.correctAnswers) / \(self.gamePlay.getTotalScore()) ")
                        .font(.system(size: 30, weight: .black))
                        .foregroundColor(Color.rgb(r: 62, g: 102, b: 171))
                }
                .padding(.bottom, 60)
                .padding(.top, 100)
                
                Spacer()
                
                Button(action: {
                    self.gamePlay.stop()
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                        .background(Color.lightBlue)
                        .cornerRadius(8)
                        .frame(height: 47)
                        .overlay(
                            Text("Restart")
                                .foregroundColor(Color.backgroundColor)
                                .font(.system(size: 17, weight: .semibold))
                    )
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                }.padding(.bottom, 20)
                
                Button(action: {
                    self.gamePlay.stop()
                }) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                        .background(Color.rgb(r: 28, g: 65, b: 116))
                        .cornerRadius(8)
                        .frame(height: 47)
                        .overlay(
                            Text("Start Game")
                                .foregroundColor(Color.backgroundColor)
                                .font(.system(size: 17, weight: .semibold))
                    )
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
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
