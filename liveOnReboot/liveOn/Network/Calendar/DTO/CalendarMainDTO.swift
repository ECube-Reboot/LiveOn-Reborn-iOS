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
    let eventResponseList: [EventResponseList]
    let monthResponses: [MonthResponse]
}

struct EventResponseList: Codable {
    let upcomingEventDate: String
    let upcomingEventID: Int64
    let upcomingEventMemo: String
    let upcomingEventTitle: String

    enum CodingKeys: String, CodingKey {
        case upcomingEventDate
        case upcomingEventID = "upcomingEventId"
        case upcomingEventMemo
        case upcomingEventTitle
    }
}

struct MonthResponse: Codable {
    let createdAt: String
    let giftType: String
}
