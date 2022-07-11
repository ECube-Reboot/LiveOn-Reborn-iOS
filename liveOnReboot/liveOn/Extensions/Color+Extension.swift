//
//  Color+Extension.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/07/11.
//

import Foundation
import SwiftUI

extension Color {
    static let backgroundGray = Color(hex: "#FCFAFA")
    static let burgundy = Color(hex: "#6B0600")
    static let body = Color(hex: "#5A4C4C")
    static let lightgray = Color(hex: "#F2F0F0") //shadow 또는 박스 배경
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
