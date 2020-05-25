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
    
    var body: some View {
        NavigationView {
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
                    Spacer()
                }
            }
            .navigationBarTitle("\(self.gamePlay.answersCount)/\(self.gamePlay.totalFlashCardCount)", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.gamePlay.stop()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                        
                    }
                    .foregroundColor(Color.firstColor)
                    .font(.system(size: 18, weight: .semibold))
                })
            )
        }
    }
}

struct GamePlayView_Previews: PreviewProvider {
    static var previews: some View {
        GamePlayView()
    }
}
