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
    DeckColor(name: "blue", colorOne: Color.rgb(r: 89, g: 196, b: 244), colorTwo: Color.rgb(r: 65, g: 113, b: 136)),
    DeckColor(name: "orange", colorOne: Color.rgb(r: 252, g: 157, b: 12), colorTwo: Color.rgb(r: 185, g: 116, b: 15)),
    DeckColor(name: "yellow", colorOne: Color.rgb(r: 252, g: 202, b: 1), colorTwo: Color.rgb(r: 189, g: 154, b: 11)),
    DeckColor(name: "green", colorOne: Color.rgb(r: 51, g: 194, b: 86), colorTwo: Color.rgb(r: 30, g: 96, b: 46)),
    DeckColor(name: "purple", colorOne: Color.rgb(r: 172, g: 81, b: 218), colorTwo: Color.rgb(r: 115, g: 53, b: 146)),
    DeckColor(name: "red ", colorOne: Color.rgb(r: 251, g: 58, b: 48), colorTwo: Color.rgb(r: 149, g: 35, b: 29)),
]
