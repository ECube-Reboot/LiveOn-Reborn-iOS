//
//  UpcomingEventsModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI

class UpcomingEventsModel: Identifiable, ObservableObject {
    let id: UUID
    let upcomingEventdate: String
    let upcomingEventTitle: String
    let upcomingEventMemo: String
    init(upcomingEventDate: Date, upcomingEventTitle: String, upcomingEventMemo: String) {
        id = UUID()
        self.upcomingEventdate = DateToStringEventMonth(upcomingEventDate)
        self.upcomingEventTitle = upcomingEventTitle
        self.upcomingEventMemo = upcomingEventMemo
    }
}
