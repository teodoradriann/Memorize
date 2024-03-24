//
//  RGBA.swift
//  Memorize
//
//  Created by Teodor Adrian on 3/23/24.
//

import SwiftUI

struct RGBA: Codable, Equatable, Hashable, ShapeStyle{
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}


extension Color {
    init(rgba: RGBA) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }
}


extension RGBA {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
}
