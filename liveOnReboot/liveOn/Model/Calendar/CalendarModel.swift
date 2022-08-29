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

struct CalendarMain {
    private var id = UUID()

    var upcomingEventTitle: String = ""
    var upcomingEventMemo: String = ""
    
    var upcomingEventDate: Date = Date()
    var upcomingEventdate: String {
        return Date().eventDateToString(upcomingEventDate)
    }
}
