//
//  CalendarMainDTO.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import Foundation
import Moya

struct CalendarMainPostRequest: Codable {
    let upcomingEventdate: String
    let upcomingEventTitle: String
    let upcomingEventMemo: String
}

struct CalendarMainGetResponse: Codable {
    let calendarMains: [CalendarMainGet]
}

struct CalendarMainGet: Codable {
    let upcomingEventId: Int64
    let upcomingEventdate: String
    let upcomingEventTitle: String
    let upcomingEventMemo: String
    let createdAt: String
    let giftType: String
}
