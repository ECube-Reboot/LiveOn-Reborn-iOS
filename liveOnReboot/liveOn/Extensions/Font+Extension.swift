//
//  Font+Extension.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/07/11.
//

import Foundation
import SwiftUI

// 사용 예시 : Text("리본").font(.TextStyles.largeCalendarNumber)

enum liveOnFonts: String {
    // 캘린더뷰에 사용되는 월,년 표시용 폰트
    case calendarNumber = "NerkoOne-Regular"
    // 편지, 사진뷰에 사용되는 손글씨 폰트
    case handWritten = "나눔손글씨 중학생"
}
// 폰트 추가 원할 시, asset폴더에 폰트 파일 추가 위 enum에 case 추가, info plist에 추가 하시면 됩니다.

extension Font {
    enum TextStyles {
        // 캘린더뷰에 사용되는 월,년 표시용 폰트
        static var largeCalendarNumber: Font { Font.liveOnFont(weight: .calendarNumber, size: 60.0)}
        static var mediumCalendarNumber: Font { Font.liveOnFont(weight: .calendarNumber, size: 32.0)}
        static var smallCalendarNumber: Font { Font.liveOnFont(weight: .calendarNumber, size: 24.0)}
        
        // 편지용 손글씨 폰트
      static var handWrittenTitle: Font { Font.liveOnFont(weight: .handWritten, size: 32.0)}
        static var handWrittenBody: Font { Font.liveOnFont(weight: .handWritten, size: 26.0)}
        static var handWrittenCallout: Font { Font.liveOnFont(weight: .handWritten, size: 24.0)}
    }
}

private extension Font {
    static func liveOnFont(weight: liveOnFonts, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
}
