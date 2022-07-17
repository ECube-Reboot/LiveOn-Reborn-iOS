//
//  UpcomingEventsModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI

class UpcomingEventsModel: Identifiable, ObservableObject {
    let id: UUID
    let upcomingEventDate: String
    let upcomingEventTitle: String
    let upcomingEventMemo: String
    init(upcomingEventDate: Date, upcomingEventTitle: String, upcomingEventMemo: String) {
        id = UUID()
        self.upcomingEventDate = DateToStringUpcomingEventsViewModel(upcomingEventDate)
        self.upcomingEventTitle = upcomingEventTitle
        self.upcomingEventMemo = upcomingEventMemo
    }
}

class EventStore: ObservableObject {
    @Published var list: [UpcomingEventsModel]
    
    init() {
        list = []
    }
    
    func insert(upcomingEventDate: Date, upcomingEventTitle: String, upcomingEventMemo: String) {
        list.insert(UpcomingEventsModel(upcomingEventDate: upcomingEventDate, upcomingEventTitle: upcomingEventTitle, upcomingEventMemo: upcomingEventMemo), at: 0)
    }
}
