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
        VStack{
            Spacer()
            
            VStack {
                Text(self.gamePlay.scoreboard.text)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(self.gamePlay.scoreboard.color)
                    .padding(.bottom, 20)
                
                Image(self.gamePlay.scoreboard.image)
                    .frame(height: 150)
                    .padding(.bottom, 20)
                
                Text(self.gamePlay.scoreboard.sentence)
                    .fixedSize()
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color.darkBlue)
                    .padding(.bottom, 20)
                
                Text("\(self.gamePlay.correctAnswers) / \(self.gamePlay.totalFlashCardCount) ")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(Color.rgb(r: 62, g: 102, b: 171))
            }
            .padding(.bottom, 15)
            .padding(.top, 25)
            .opacity(dim ? 1.0 : 0.5)
            .offset(y: dim ? 0 : 120)
            .animation(self.animation)
            .onAppear {
                withAnimation(.easeOut(duration: 0.4)) {
                    self.dim.toggle()
                }
            }
            
            Spacer()
            
            Button(action: {
                self.gamePlay.stop()
                self.gamePlay.start()
            }) {
                ButtonView(text: "Restart", backgroundColor: Color.lightBlue)
            }.padding(.bottom, 20).frame(maxWidth: 600)
            
            Button(action: {
                self.gamePlay.stop()
                self.gamePlay.reset()
            }) {
                ButtonView(text: "Exit", backgroundColor: Color.darkBlue)
            }.frame(maxWidth: 600)
            Spacer()
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
