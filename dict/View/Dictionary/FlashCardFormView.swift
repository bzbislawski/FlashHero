//
//  FlashCardFormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FlashCardFormView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @Environment(\.presentationMode) var presentationMode
    @State private var word: String = ""
    @State private var translation: String = ""
    var deck: Deck
    var flashCard: FlashCard?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 5) {
                    VStack {
                        Image(systemName: "doc")
                            .frame(width: 32, height: 32)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.firstColor)
                        Text("Flash Card")
                            .foregroundColor(.firstColor)
                            .font(.system(size: 32, weight: .bold))
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                    HStack {
                        Text("Word")
                            .foregroundColor(.firstColor)
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                    }.frame(width: 250)
                    
                    ZStack {
                        TextField("", text: $word)
                            .frame(width: 250, height: 40)
                            .background(Color.backgroundColor)
                            .cornerRadius(5)
                        HStack {
                            Spacer()
                            Button(action:
                                {
                                    self.word = ""
                            })
                            {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.tertiaryBackgroundColor)
                            }
                            .padding(.trailing, 8)
                        }.frame(width: 250)
                    }.padding(.bottom, 20)
                    
                    HStack {
                        Text("Translation")
                            .foregroundColor(.firstColor)
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                    }.frame(width: 250)
                    
                    ZStack {
                        TextField("", text: $translation)
                            .frame(width: 250, height: 40)
                            .background(Color.backgroundColor)
                            .cornerRadius(5)
                        HStack {
                            Spacer()
                            Button(action:
                                {
                                    self.translation = ""
                            })
                            {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.tertiaryBackgroundColor)
                            }
                            .padding(.trailing, 8)
                        }.frame(width: 250)
                    }
                    
                    Spacer()
                    
                    if (self.flashCard != nil) {
                        Button(action: {
                            self.gameStatus.delete(flashCard: self.flashCard!)
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "trash")
                                .font(.system(size: 24, weight: .light))
                                .foregroundColor(Color.white)
                                .frame(width: 64, height: 64)
                                .background(Color.red)
                                .cornerRadius(5)
                        }.padding(.bottom, 50)
                    }
                    
                }.navigationBarTitle("", displayMode: .inline)
                    .background(NavigationConfigurator { nc in
                        nc.navigationBar.barTintColor = UIColor.backgroundColor
                    })
                    .navigationBarItems(
                        leading:
                        Button(action: { self.presentationMode.wrappedValue.dismiss() }) { Text("Cancel").foregroundColor(Color.firstColor).font(.system(size: 18, weight: .semibold)) },
                        trailing: Button(action: {
                            if (self.flashCard != nil) {
                                self.flashCard!.word = self.word
                                self.flashCard!.translation = self.translation
                                self.gameStatus.save(deck: self.deck, flashCard: self.flashCard!)
                            } else {
                                self.gameStatus.save(deck: self.deck, word: self.word, translation: self.translation)
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        }) { Text("Done").foregroundColor(Color.firstColor).font(.system(size: 18, weight: .semibold)) }
                )
                    .onAppear {
                        self.word = self.flashCard?.wrappedWord ?? self.word
                        self.translation = self.flashCard?.translation ?? self.translation
                }
                
            }
        }
    }
}

struct FlashCardFormView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardFormView(deck: Deck())
    }
}
