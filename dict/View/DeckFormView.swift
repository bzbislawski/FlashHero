//
//  DeckFormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct DeckFormView: View {
    @Environment (\.presentationMode) var presentationMode
    @State private var name: String = ""
    var deck: Deck?
    
    @EnvironmentObject var gameStatus: GameStatus
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 5) {
                    VStack {
                        Image(systemName: "square.stack.3d.down.right")
                            .frame(width: 32, height: 32)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.firstColor)
                        Text("Deck")
                            .foregroundColor(.firstColor)
                            .font(.system(size: 32, weight: .bold))
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                    
                    HStack {
                        Text("Name")
                            .foregroundColor(.firstColor)
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                    }.frame(width: 250)
                    
                    ZStack {
                        TextField("", text: $name)
                            .frame(width: 250, height: 40)
                            .background(Color.backgroundColor)
                            .cornerRadius(5)
                        HStack {
                            Spacer()
                            Button(action: { self.name = "" })
                            {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.tertiaryBackgroundColor)
                            }
                            .padding(.trailing, 8)
                        }.frame(width: 250)
                    }
                    
                    Button(action: {
                        if (self.deck == nil) {
                            self.gameStatus.save(name: self.name, color: "default")
                        } else {
                            self.gameStatus.save(deck: self.deck!, name: self.name, color: "default")
                        }
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
                    .onAppear {
                        self.name = self.deck?.wrappedName ?? self.name
                }
                
            }
        }
    }
}


struct DeckFormView_Previews: PreviewProvider {
    static var previews: some View {
        DeckFormView()
    }
}
