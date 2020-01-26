//
//  FlashCardFormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FlashCardFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var word: String = ""
    @State private var translation: String = ""
    var deck: Deck
    
    @EnvironmentObject var gameStatus: GameStatus
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 15) {
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
                    .padding(.bottom, 50)
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
                    }
                    
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
                    Button(action: {
                        self.gameStatus.save(deck: self.deck, word: self.word, translation: self.translation)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        VStack {
                            Text("Save")
                                .frame(width: 250, height: 40)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.white)
                        }
                        .background(Color.firstColor)
                        .cornerRadius(5)
                    }.padding(.top, 25)
                    Spacer()
                    
                }.navigationBarTitle("", displayMode: .inline)
                    .background(NavigationConfigurator { nc in
                        nc.navigationBar.barTintColor = UIColor.backgroundColor
                    })
                    .navigationBarItems(
                        leading:
                        Button(action: { self.presentationMode.wrappedValue.dismiss() }) { Text("Cancel").foregroundColor(Color.firstColor).font(.system(size: 16, weight: .semibold)) }
                )
                
            }
        }
    }
}

struct FlashCardFormView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardFormView(deck: Deck())
    }
}
