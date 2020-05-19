//
//  BackgroundView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 03/05/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    let gradient = Gradient(colors: [Color.rgb(r: 190, g: 232, b: 241), Color.backgroundColor])
    
    var body: some View {
        ZStack {
            Color.backgroundColor
            
            GeometryReader { geometry in
                Rectangle()
                    .fill(
                        RadialGradient(
                            gradient: self.gradient,
                            center: UnitPoint(x: 0.15, y: 0),
                            startRadius: 0,
                            endRadius: 480
                        )
                )
                    .frame(width: geometry.size.width, height:geometry.size.height * 0.4)
                Spacer()
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
