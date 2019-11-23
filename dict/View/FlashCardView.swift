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
    @Binding var showAnswer: Bool
    var word: String
    var translation: String
    
    var body: some View {
        ZStack {
            Image("rectangle")
                .resizable()
                .cornerRadius(10)
                .frame(width: 320, height: 220)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(self.colorScheme == .light ? Color.white : Color.gray, lineWidth: 4))
                .shadow(radius: 5)
            
            Text(self.word)
                .bold()
                .font(.title)
//                .opacity(self.showAnswer ? 0 : 1)
            
            Text(self.translation)
              
                .bold()
                .font(.title)
//                .opacity(showAnswer ? 1 : 0)
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
//                .offset(x: 0, y: 60)
        }
    }
}

struct FlashCardView_Previews: PreviewProvider {
    @Binding var param: Bool
    static var previews: some View {
        Game()
    }
}
