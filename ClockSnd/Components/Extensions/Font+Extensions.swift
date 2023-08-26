//
//  Font+Extensions.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import Foundation
import SwiftUI

extension Font {
    enum FontFamily: String {
        case nunito = "Nunito"
        case jost = "Jost"
        // Add more font families as needed
    }

    enum FontStyle: String {
        case black
        case blackItalic = "blackitalic"
        case bold
        case boldItalic = "bolditalic"
        case extraBold = "extrabold"
        case extraBoldItalic = "extrabolditalic"
        case extraLight = "extralight"
        case extraLightItalic = "extralightitalic"
        case italic
        case light
        case lightItalic = "lightitalic"
        case medium
        case mediumItalic = "mediumitalic"
        case regular
        case semiBold = "semibold"
        case semiBoldItalic = "semibolditalic"
    }

    static func customFont(family: FontFamily, style: FontStyle, size: CGFloat) -> Font {
        let fontName = "\(family.rawValue)-\(style.rawValue.capitalized)"
        if let font = UIFont(name: fontName, size: size) {
            return Font(font)
        } else {
            return Font.system(size: size)
        }
    }
}
