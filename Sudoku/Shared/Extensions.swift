//
//  Extensions.swift
//  Sudoku
//
//  Created by Raymond Kim on 6/2/20.
//  Copyright © 2020 Self. All rights reserved.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }

    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    /// E.g., 12.9-inch iPads
    var isLargestIpad: Bool {
        isIpad && screenWidth > 1023
    }

    var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }

    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
}

extension ViewModifier {
    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    /// E.g., 12.9-inch iPads
    var isLargestIpad: Bool {
        isIpad && screenWidth > 1023
    }
}

extension Color: Codable {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    // Convert Color to hex string
    func toHex() -> String? {
        let components = UIColor(self).cgColor.components
        guard let red = components?[0], let green = components?[1], let blue = components?[2] else {
            return nil
        }
        let alpha = components?.count == 4 ? components?[3] : 1.0
        if alpha == 1.0 {
            return String(format: "#%02lX%02lX%02lX", lround(Double(red * 255)), lround(Double(green * 255)), lround(Double(blue * 255)))
        } else {
            return String(format: "#%02lX%02lX%02lX%02lX", lround(Double(alpha! * 255)), lround(Double(red * 255)), lround(Double(green * 255)), lround(Double(blue * 255)))
        }
    }
    
    public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let hexString = try container.decode(String.self)
            self.init(hex: hexString)
        }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        guard let hexString = self.toHex() else {
            throw EncodingError.invalidValue(self, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "invalid color"))
        }
        try container.encode(hexString)
    }
}
