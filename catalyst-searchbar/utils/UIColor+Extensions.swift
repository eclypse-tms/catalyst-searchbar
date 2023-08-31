//
//  UIColor+Extensions.swift
//  
//  Created by Turker Nessa Kucuk on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import UIKit

extension UIColor {
    class func hexStr (hexStr: String) -> UIColor {
        return UIColor(with: hexStr) ?? .black
    }
    
    enum HexRepresentation {
        case sixDigit
        case eightDigit
    }
    
    // MARK: - Initialization
    /// knownValidHex can be either 6 or 8 digits.
    convenience init(knownValidHex: String) {
        var hexSanitized = knownValidHex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        let length = String(hexSanitized).count
        
        if Scanner(string: hexSanitized).scanHexInt64(&rgb) {
            if length == 6 {
                red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(rgb & 0x0000FF) / 255.0

            } else if length == 8 {
                red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat(rgb & 0x000000FF) / 255.0
            }
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init?(with hexCandidate: String) {
        var hexSanitized = hexCandidate.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        let length = String(hexSanitized).count
        
        if Scanner(string: hexSanitized).scanHexInt64(&rgb) {
            if length == 6 {
                red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(rgb & 0x0000FF) / 255.0

            } else if length == 8 {
                red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat(rgb & 0x000000FF) / 255.0
            } else {
                return nil
            }
        } else {
            return nil
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // MARK: - From UIColor to String
    
    func toHex(_ hexRepresentation: HexRepresentation = .sixDigit) -> String {
        var red = Float.zero
        var green = Float.zero
        var blue = Float.zero
        var alpha = Float(1.0)
        
        guard let components = cgColor.components, components.count >= 3 else {
            switch hexRepresentation {
            case .sixDigit:
                return String(format: "%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
            case .eightDigit:
                return String(format: "%02lX%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255), lroundf(alpha * 255))
            }
        }
        
        red = Float(components[0])
        green = Float(components[1])
        blue = Float(components[2])
        
        if components.count >= 4 {
            alpha = Float(components[3])
        }
        
        switch hexRepresentation {
        case .sixDigit:
            return String(format: "%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
        case .eightDigit:
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255), lroundf(alpha * 255))
        }
        
    }
    
}
