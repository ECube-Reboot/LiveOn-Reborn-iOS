//
//  Text+Extension.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/19.
//
import SwiftUI

extension Text {
    func mainTextStyle() -> some View {
        foregroundColor(.mainBrown)
            .font(.system(size: 20))
            .fontWeight(.regular)
    }
    
    func letterCountSyle() -> some View {
        modifier(LetterCountCaption())
    }
}

struct LetterCountCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundColor(.textBodyColor)
            .opacity(0.6)
            .padding(.vertical)
    }
}


