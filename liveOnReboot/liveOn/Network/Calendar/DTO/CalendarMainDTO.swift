//
//  CalendarMainDTO.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import Foundation
import Moya

struct CalendarMainPostResponse: Encodable {
    let createdAt: String
    let giftType: String
}

struct CalendarMainGetResponse: Decodable {
    let createdAt: String
    let giftType: String
}
