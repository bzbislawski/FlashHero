//
//  Extensions.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

extension Color {
    static func rgb(r: Double, g: Double, b: Double) -> Color {
        return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
    
    static let backgroundColor = Color.rgb(r: 241, g: 242, b: 244)
    static let secondaryBackgroundColor = Color.rgb(r: 209, g: 214, b: 217)
    static let firstColor = Color.rgb(r: 10, g: 94, b: 74)
    static let blackFont = Color.rgb(r: 71, g: 71, b: 71)
    static let grayFont = Color.rgb(r: 124, g: 124, b: 124)
    static let lightGrayFont = Color.rgb(r: 80, g: 80, b: 80)
    
}

extension UIColor {
    static let backgroundColor = UIColor(red:216/255, green:216/255, blue:216/255, alpha: 1.0)
    static let secondaryBackgroundColor = UIColor(red:0.6, green:0.6, blue:0.6, alpha: 1.0)
    static let blackFont = UIColor(red: 71, green: 71, blue: 71, alpha: 1.0)
}
