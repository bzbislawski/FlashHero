//
//  ButtonView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 08/05/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    let backgroundColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
            .background(self.backgroundColor)
            .cornerRadius(8)
            .frame(height: 47)
            .overlay(
                Text(self.text)
                    .foregroundColor(Color.backgroundColor)
                    .font(.system(size: 17, weight: .semibold))
        )
            .padding(.leading, 40)
            .padding(.trailing, 40)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Button", backgroundColor: Color.backgroundColor)
    }
}
