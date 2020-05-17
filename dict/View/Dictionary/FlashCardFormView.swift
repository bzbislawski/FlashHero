//
//  FlashCardFormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FlashCardFormView: View {
    @EnvironmentObject var activeSheetHandler: ActiveSheetHandler
    @EnvironmentObject var gameStatus: GameStatus
    @Binding var showSheet: Bool
    @State private var word: String = ""
    @State private var translation: String = ""
    
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
                HStack {
                    Button(action:
                        {
                            self.gameStatus.delete(flashCard: self.activeSheetHandler.activeFlashCard!)
                            self.showSheet.toggle()
                            self.activeSheetHandler.delayHideView()
                    })
                    {
                        Image(systemName:"trash").foregroundColor(Color.backgroundColor)
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.red)
                    .cornerRadius(8)
                    Spacer()
                }.padding(.leading, 20)
                
                Text("Flashcard")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.rgb(r: 53, g: 54, b: 67))
            }
            
            Divider()
            
            ZStack {
                TextField("", text: $word)
                    .padding(.leading, 10)
                    .padding(.trailing, 30)
                    .frame(height: 40)
                    .background(Color.secondaryBackgroundColor)
                    .cornerRadius(15)
                HStack {
                    Spacer()
                    Button(action: { self.word = "" })
                    {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.tertiaryBackgroundColor)
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 15)
            .padding(.top, 15)
            
            Divider()
            
            
            ZStack {
                TextField("", text: $translation)
                    .padding(.leading, 10)
                    .padding(.trailing, 30)
                    .frame(height: 40)
                    .background(Color.secondaryBackgroundColor)
                    .cornerRadius(15)
                HStack {
                    Spacer()
                    Button(action: { self.word = "" })
                    {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.tertiaryBackgroundColor)
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 15)
            .padding(.top, 15)
            
            Button(action: {
                if (self.activeSheetHandler.activeFlashCard != nil) {
                    self.activeSheetHandler.activeFlashCard!.word = self.word
                    self.activeSheetHandler.activeFlashCard!.translation = self.translation
                    self.gameStatus.save(deck: self.activeSheetHandler.activeDeck!, flashCard: self.activeSheetHandler.activeFlashCard!)
                } else {
                    self.gameStatus.save(deck: self.activeSheetHandler.activeDeck!, word: self.word, translation: self.translation)
                }
                self.showSheet.toggle()
                self.activeSheetHandler.delayHideView()
            }) {
                ButtonView(text: "Save", backgroundColor: Color.darkBlue, horizontalPadding: 20)
            }
            .onAppear {
                self.word = self.activeSheetHandler.activeFlashCard?.wrappedWord ?? self.word
                self.translation = self.activeSheetHandler.activeFlashCard?.translation ?? self.translation
            }
        }
    }
}

struct FlashCardFormView_Previews: PreviewProvider {
    struct Wrapper: View {
        @State var show: Bool = true
        var body: some View {
            let env = ActiveSheetHandler()
            return FlashCardFormView(showSheet: self.$show).environmentObject(env)
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}
