//
//  MiniFlashCardView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 26/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct MiniFlashCardView: View {
    var flashCard: FlashCard
    
    var body: some View {
        ZStack {
            Image("rectangle")
                .resizable()
                .cornerRadius(10)
                .frame(width: 160, height: 100)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
                .shadow(radius: 5, x: 0, y: 4)
            
            Text(flashCard.wrappedWord)
                .bold()
                .font(.system(size: 22))
                .foregroundColor(Color.white)
                .frame(maxWidth: 280)
                .shadow(radius: 10)
        }
        .padding(.top, 5)
        .padding(.bottom)
        .padding(.trailing, 20)
        .padding(.leading, 20)
    }
}

struct MiniFlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        MiniFlashCardView(flashCard: FlashCard())
    }
}
