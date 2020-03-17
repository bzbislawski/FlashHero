//
//  CardsOrderView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 16/03/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct CardsOrderView: View {
    @Environment (\.presentationMode) var presentationMode
    @Binding var cardsOrderOption: String
    
    var cardsOrder: Array<String> {
        return ["Default", "Alphabetical", "Random"]
    }
    
    var body: some View {
        NavigationView {
            List(self.cardsOrder, id: \.self) { type in
                Button(action: {
                    self.cardsOrderOption = type
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text(type)
                            .font(.headline)
                        Spacer()
                        if self.cardsOrderOption == type {
                            Image(systemName: "checkmark")
                                .font(Font.title.weight(.light))
                                .foregroundColor(Color.firstColor)
                                .padding(.trailing, 10)
                        }
                    }
                }
            }
            .navigationBarTitle("Select order")
            .navigationBarItems(
                trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Dismiss")
                        .foregroundColor(Color.firstColor)
                        .font(.system(size: 18, weight: .semibold))
                })
            )
        }
    }
}

struct CardsOrderView_Previews: PreviewProvider {
    struct CardsOrderViewWrapper: View {
        @State var name: String = "Default"
        var body: some View {
            CardsOrderView(cardsOrderOption: self.$name)
        }
    }
    
    static var previews: some View {
        CardsOrderViewWrapper()
    }
}
