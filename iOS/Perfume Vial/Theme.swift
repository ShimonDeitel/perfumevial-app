import SwiftUI

enum Theme {
    static let accent = Color(hex: "#C79A3B")
    static let background = Color(hex: "#14110C")
    static let backgroundSecondary = Color(hex: "#1F1911")
    static let card = Color(hex: "#2A2216")
    static let textPrimary = Color(hex: "#F6EEDD")
    static let textSecondary = Color(hex: "#D2BE93")

    static let titleFont = Font.system(.title2, design: .serif).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .default)
}

extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}
