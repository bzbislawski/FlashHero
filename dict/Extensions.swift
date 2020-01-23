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
    
    static let backgroundColor = Color.rgb(r: 216, g: 216, b: 216)
    static let secondaryBackgroundColor = Color.rgb(r: 200, g: 200, b: 200)
    static let firstColor = Color.rgb(r: 10, g: 94, b: 74)
    static let blackFont = Color.rgb(r: 55, g: 55, b: 55)
    static let grayFont = Color.rgb(r: 124, g: 124, b: 124)
}

extension UIColor {
    static let secondaryBackgroundColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
}
