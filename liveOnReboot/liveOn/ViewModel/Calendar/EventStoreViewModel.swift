//
//  EventStoreViewModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/08/02.
//

import SwiftUI

class EventStore: ObservableObject {
    @Published var list: [UpcomingEventsModel]
    
    init() {
        list = []
    }
    
    func insert(upcomingEventDate: Date, upcomingEventTitle: String, upcomingEventMemo: String) {
        list.insert(UpcomingEventsModel(upcomingEventDate: upcomingEventDate, upcomingEventTitle: upcomingEventTitle, upcomingEventMemo: upcomingEventMemo), at: 0)
    }
}
