//
//  CalendarMainDTO.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import Foundation
import Moya
struct CalendarMainGetRequest: Codable {
    let calendarRequest: String
}
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
    
    init() {
        eventResponseList =  [EventResponseList]()
        monthResponses = [MonthResponse]()
    }
}

struct EventResponseList: Codable {
    let upcomingEventDate: String
    let upcomingEventId: Int64
    let upcomingEventMemo: String
    let upcomingEventTitle: String
}

struct MonthResponse: Codable {
    let createdAt: String
    let giftType: String
}
