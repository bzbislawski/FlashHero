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
    @Binding var showSheet: Bool
    @State private var name: String = ""
    @State private var color: String = ""
    @State private var showingValidationAlert = false
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .fill(Color.secondaryBackgroundColor)
                    .frame(width: UIScreen.main.bounds.width / 6, height: 4)
                    .cornerRadius(2)
                    .padding(.top, 10)
            }
            
            ZStack {
                if self.activeSheetHandler.activeDeck != nil {
                    HStack {
                        Button(action:
                        {
                            self.showingDeleteAlert = true
                        })
                        {
                            Image(systemName:"trash").foregroundColor(Color.backgroundColor)
                        }
                        .frame(width: 44, height: 44)
                        .background(Color.red)
                        .cornerRadius(8)
                        Spacer()
                    }.padding(.leading, 20)
                }
                Text("Dictionary")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.rgb(r: 53, g: 54, b: 67))
            }
            
            Divider()
            
            ZStack {
                TextField("Name", text: $name)
                    .padding(.leading, 10)
                    .padding(.trailing, 30)
                    .frame(height: 40)
                HStack {
                    Spacer()
                    Button(action: { self.name = "" })
                    {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.tertiaryBackgroundColor)
                    }
                    .padding(.trailing, 10)
                }
            }
            .background(Color.secondaryBackgroundColor)
            .cornerRadius(15)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 15)
            .padding(.top, 15)
            
            Divider()
            
            HStack {
                ForEach(0 ..< deckColors.count) { value in
                    
                    Button(action:
                        {
                            self.color = deckColors[value].name
                    })
                    {
                        Spacer()
                        Circle()
                            .fill(deckColors[value].colorOne)
                            .overlay(
                                ZStack {
                                    RoundedRectangle(cornerRadius: .infinity)
                                        .strokeBorder(Color.white, lineWidth: self.color == deckColors[value].name ? 4 : 0)
                                    RoundedRectangle(cornerRadius: .infinity)
                                        .stroke(Color.lightBlue, lineWidth: self.color == deckColors[value].name ? 3 : 0)
                                }
                        )
                            .animation(Animation.easeInOut(duration: 0.1))
                            .frame(width: 44, height: 44)
                        Spacer()
                    }
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 15)
            .padding(.top, 15)
            
            Button(action: {
                if (self.activeSheetHandler.activeDeck == nil) {
                    self.gameStatus.save(name: self.name, color: self.color)
                    self.showSheet.toggle()
                    self.activeSheetHandler.delayHideView()
                    return
                }
                if self.name == "" {
                    self.showingValidationAlert = true
                } else {
                    self.gameStatus.save(deck: self.activeSheetHandler.activeDeck!, name: self.name, color: self.color)
                    self.showSheet.toggle()
                    self.activeSheetHandler.delayHideView()
                }
            }) {
                ButtonView(text: "Save", backgroundColor: Color.darkBlue, horizontalPadding: 20)
            }
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
        .alert(isPresented: $showingDeleteAlert) { () -> Alert in
            Alert(title: Text("Are you sure?"), message: Text("Deck and its flashcards will be deleted permanently."),
                  primaryButton: .default(Text("Yes"), action: {
                    self.gameStatus.delete(deck: self.activeSheetHandler.activeDeck!)
                    self.showSheet.toggle()
                    self.activeSheetHandler.delayHideView()
                  }),
                  secondaryButton: .default(Text("Cancel")))
        }
    }
}

struct DeckFormView_Previews: PreviewProvider {
    struct Wrapper: View {
        @State var show: Bool = true
        var body: some View {
            let env = ActiveSheetHandler()
            return DeckFormView(showSheet: self.$show).environmentObject(env)
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}
