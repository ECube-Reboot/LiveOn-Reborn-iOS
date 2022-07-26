//
//  LetterModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct Letter {
  private var id = UUID()
  var content: String = ""
  var sender: String = ""
  var createdAt: Date = Date.now
  
  var createdDate: String {
    return Date().dateToString(createdAt)
  }
  
}
