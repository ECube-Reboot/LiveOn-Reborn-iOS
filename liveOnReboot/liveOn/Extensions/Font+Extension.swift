//
//  Font+Extension.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/07/11.
//
import Foundation
import SwiftUI

enum liveOnFonts: String {
    case calendarNumber = "NerkoOne-Regular"
    case handWritten = "NanumJungHagSaeng"
}

extension Font {
    enum TextStyles {
        
        static var largeCalendarNumber: Font { Font.liveOnFont(weight: .calendarNumber, size: 60.0)}
        static var mediumCalendarNumber: Font { Font.liveOnFont(weight: .calendarNumber, size: 32.0)}
        static var smallCalendarNumber: Font { Font.liveOnFont(weight: .calendarNumber, size: 24.0)}
    
      static var handWrittenTitle: Font { Font.liveOnFont(weight: .handWritten, size: 32.0)}
        static var handWrittenBody: Font { Font.liveOnFont(weight: .handWritten, size: 26.0)}
        static var handWrittenCallout: Font { Font.liveOnFont(weight: .handWritten, size: 24.0)}
        static var handWrittenCaption: Font { Font.liveOnFont(weight: .handWritten, size: 12.0)}
    }
}

private extension Font {
    static func liveOnFont(weight: liveOnFonts, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
}

struct FontNames {
    static let handWritten = "나눔손글씨 나의 아내 손글씨"
}

extension Text {
    func setHandWritten() -> some View {
        self.font(.custom(FontNames.handWritten, size: 24))
    }
}

extension TextEditor {
    func setHandWritten() -> some View {
        self.font(.custom(FontNames.handWritten, size: 24))
    }
}

extension View {
    func setHandWritten() -> some View {
        self.font(.custom(FontNames.handWritten, size: 24))
    }
}

extension TextField {
    func setHandWritten() -> some View {
        self.font(.custom(FontNames.handWritten, size: 24))
    }
}
