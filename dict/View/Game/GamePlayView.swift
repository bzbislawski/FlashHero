//
//  GamePlayView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/05/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct GamePlayView: View {
    @EnvironmentObject var gamePlay: GamePlay
    @State var showsAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("\(self.gamePlay.answersCount)/\(self.gamePlay.totalFlashCardCount)")
                        .foregroundColor(.fontColor)
                        .font(.system(size: 32, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        self.showsAlert.toggle()
                    }, label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 44, height: 44)
                                .cornerRadius(12)
                            Image(systemName: "xmark")
                                .foregroundColor(Color.darkBlue)
                                .font(.system(size: 24, weight: .bold))
                        }
                    })
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 60)
                .frame(maxHeight: 44)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 10)
                .padding(.bottom, 20)
                                
                Spacer()
                
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.gamePlay.flashCards, id: \.self) { flashCard in
                            FlashCardView(flashCard: flashCard)
                                .animation(.spring())
                                .padding(.top, 15)
                                .padding(.bottom, 15)
                                .padding(.leading, 300)
                                .padding(.trailing, 300)
                        }
                    }
                    
                }
            }.alert(isPresented: self.$showsAlert, content: { () -> Alert in
                Alert(title: Text("Leave the game?"), message: Text("All the progress will be lost."),
                      primaryButton: .default(Text("Yes"), action: {
                        self.gamePlay.stop()
                        self.gamePlay.reset()
                      }),
                      secondaryButton: .default(Text("Cancel")))
            })
        }
        
    }
}

struct GamePlayView_Previews: PreviewProvider {
    static var previews: some View {
        let gamePlay = GamePlay()
        return GamePlayView().environmentObject(gamePlay)
    }
}
