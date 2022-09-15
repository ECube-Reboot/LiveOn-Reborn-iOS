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
    static let textBodyColor = Color(hex: "#5A4C4C")
    static let emptyGiftTextColor = Color(hex: "#A3A3A3")
    static let lightgray = Color(hex: "#F2F0F0") //shadow 또는 박스 배경
    static let cassetteGreen = Color(hex: "#717339")
    static let cassetteRed = Color(hex: "#A6633C")
    
    static let background = Color("background")
    static let bodyTextColor = Color("bodyText")
    static let placeHolderColor = Color(hex: "D9D9D9")
    static let crimson = Color(hex: "902F2F")
    static let mainBrown = Color(hex: "6C5151")

    static let recordingBtn = Color(hex: "#CC6541")
    static let recordingBtnBackground = Color(hex: "#F5F3F3")
    static let cassetteBorder = Color("CassetteBorder")
    static let deepGreen = Color(hex: "2F8F4A")
    static let coralPink = Color(hex: "DB5E5E")
    static let shadowColor = Color(hex: "F2F0F0")
    static let primaryColor = Color(hex: "#A5726F")
    
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
