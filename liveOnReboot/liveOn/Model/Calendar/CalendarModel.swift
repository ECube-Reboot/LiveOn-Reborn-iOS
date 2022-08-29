//
//  CalendarModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI
import Foundation

// Date
struct CalendarModel: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
