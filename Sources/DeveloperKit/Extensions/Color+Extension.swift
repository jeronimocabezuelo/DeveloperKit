//
//  Color+Extension.swift
//  Bitaskora
//
//  Created by Jerónimo Cabezuelo Ruiz on 21/10/24.
//

import SwiftUI

#if os(iOS)
typealias NativeColor = UIColor
#elseif os(macOS)
typealias NativeColor = NSColor
#endif

extension Color {
    public func components() -> (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var opacity: CGFloat = 0
        
        NativeColor(self).getRed(&red, green: &green, blue: &blue, alpha: &opacity)
        return (red, green, blue, opacity)
    }
    
    public func toHex() -> String {
        let components = components()
        
        let r = Int(components.red * 255.0)
        let g = Int(components.green * 255.0)
        let b = Int(components.blue * 255.0)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
    
    public init(hex: String) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
    
    public var isDarkColor: Bool {
        let components = components()
        let brightness = (0.299 * components.red + 0.587 * components.green + 0.114 * components.blue)
        return brightness < 0.5
    }
    
    public var contrastTextColor: Color {
        return isDarkColor ? .white : .black
    }
}
