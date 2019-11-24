//
//  Homepage.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Homepage: View {
    @EnvironmentObject var gameStatus: GameStatus
    @State private var showDictionary = false
    @State private var startGame = false
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: Game(), isActive: $startGame) { EmptyView() }
                
                Button(action: {
                    self.gameStatus.answers = 0
                    self.startGame = true
                }) {
                    Text("Play")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(width:120, height: 65)
                        .background(Color.blue)
                        .cornerRadius(3100)
                        .shadow(radius: 20, x: 0, y: 20)
                }
                
                NavigationLink(destination: Dictionary(), isActive: self.$showDictionary) { EmptyView()
                }
                .frame(width: 0, height: 0)
                .disabled(true)
            }
            .navigationBarItems(
                trailing: Button(action:{ self.showDictionary = true }) {
                    HStack {
                        Image(systemName: "book")
                        Text("Dictionary")
                    }.frame(minHeight: 64).font(.system(size: 18))
                }
            )
        }
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
