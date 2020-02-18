//
//  DeckColor.swift
//  dict
//
//  Created by Bartosz Zbislawski on 18/02/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation
import SwiftUI

struct DeckColor {
    var name: String
    var colorOne: Color
    var colorTwo: Color
}

let deckColors = [
    DeckColor(name: "blueee", colorOne: Color.rgb(r: 10, g: 94, b: 74), colorTwo: Color.rgb(r: 10, g: 94, b: 74)),
    DeckColor(name: "yellow", colorOne: Color.rgb(r: 10, g: 94, b: 74), colorTwo: Color.rgb(r: 10, g: 94, b: 74))
]

//LinearGradient(gradient: Gradient(colors: [Color.rgb(r: 10, g: 94, b: 74), Color.rgb(r: 10, g: 94, b: 74)]), startPoint: .topLeading, endPoint: .bottomTrailing)
