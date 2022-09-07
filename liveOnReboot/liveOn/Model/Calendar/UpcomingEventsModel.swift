//
//  UpcomingEventsModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI

class UpcomingEventsModel: Identifiable, ObservableObject {
    let upcomingEventid: UUID
    let upcomingEventdate: String
    let upcomingEventTitle: String
    let upcomingEventMemo: String
    init(upcomingEventDate: Date, upcomingEventTitle: String, upcomingEventMemo: String) {
        upcomingEventid = UUID()
        self.upcomingEventdate = DateToStringEventMonth(upcomingEventDate)
        self.upcomingEventTitle = upcomingEventTitle
        self.upcomingEventMemo = upcomingEventMemo
    }
}
