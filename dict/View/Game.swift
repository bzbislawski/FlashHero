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
    
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geometry in
                    Image("rectangle")
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: geometry.size.width * 0.95, height: geometry.size.width / 1.5)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(self.colorScheme == .light ? Color.white : Color.gray, lineWidth: 4))
                        .shadow(radius: 5)
                }
                VStack {
                    Text("haha")
                    
                }
            }//.offset(y: -150)
//            Spacer()
//            Button("Check") {
//
//            }
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
