//
//  DeckFormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct DeckFormView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @EnvironmentObject var activeSheetHandler: ActiveSheetHandler
    @State private var name: String = ""
    @State private var color: String = ""
    @State private var showingValidationAlert = false
    @State private var showingDeleteAlert = false
    var deck: Deck?
    
    var body: some View {
        VStack{
            Text("Dictionary")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color.rgb(r: 53, g: 54, b: 67))
            Divider()
            ZStack {
                TextField("", text: $name)
                    .frame(height: 40)
                    .background(Color.secondaryBackgroundColor)
                    .cornerRadius(15)
                HStack {
                    Spacer()
                    Button(action: { self.name = "" })
                    {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.tertiaryBackgroundColor)
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.leading, 50)
            .padding(.trailing, 50)
            
            Divider()
            
            HStack {
                ForEach(0 ..< deckColors.count) { value in
                    Button(action:
                        {
                            self.color = deckColors[value].name
                    })
                    {
                        Circle()
                            .fill(deckColors[value].colorOne)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.tertiaryBackgroundColor, lineWidth: self.color == deckColors[value].name ? 4 : 1)
                        )
                            .frame(width: 22, height: 22)
                    }
                    if value != deckColors.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding(.leading, 50)
            .padding(.trailing, 50)
            
            
            Button(action: {
                print(self.name)
                print(self.color)
                if (self.activeSheetHandler.activeDeck == nil) {
                    self.gameStatus.save(name: self.name, color: self.color)
                    self.activeSheetHandler.showSheet.toggle()
                    return
                }
                if self.name == "" {
                    self.showingValidationAlert = true
                } else {
                    self.gameStatus.save(deck: self.activeSheetHandler.activeDeck!, name: self.name, color: self.color)
                    self.activeSheetHandler.showSheet.toggle()
                }
            }) {
                ButtonView(text: "Save", backgroundColor: Color.darkBlue)
                
                //
            }
            
            .padding(.top, 25)
        }
        .onAppear {
            self.name = self.activeSheetHandler.activeDeck?.wrappedName ?? self.name
            self.color = self.activeSheetHandler.activeDeck?.wrappedColor ?? self.color
        }
        .alert(isPresented: $showingValidationAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Name can not be empty"),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }
}

struct DeckFormView_Previews: PreviewProvider {
    static var previews: some View {
        DeckFormView()
    }
}
