//
//  Text+Extension.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/19.
//
import SwiftUI

struct LetterCountCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundColor(.textBodyColor)
            .opacity(0.6)
            .padding(.vertical)
    }
}


