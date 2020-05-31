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
    var horizontalPadding = 40
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
            .background(self.backgroundColor)
            .cornerRadius(12)
            .frame(height: 47)
            .overlay(
                Text(self.text)
                    .foregroundColor(Color.backgroundColor)
                    .font(.system(size: 17, weight: .semibold))
        )
            .padding(.leading, CGFloat(self.horizontalPadding))
            .padding(.trailing, CGFloat(self.horizontalPadding))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Button", backgroundColor: Color.backgroundColor)
    }
}
