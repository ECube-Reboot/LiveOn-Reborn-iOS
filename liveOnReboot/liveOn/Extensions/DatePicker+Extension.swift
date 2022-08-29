//
//  DatePicker+Extension.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/08/07.
//

import SwiftUI

extension View {
  @ViewBuilder func applyTextColor(_ color: Color) -> some View {
    if UITraitCollection.current.userInterfaceStyle == .light {
      self.colorInvert().colorMultiply(color)
    } else {
      self.colorMultiply(color)
    }
  }
}
