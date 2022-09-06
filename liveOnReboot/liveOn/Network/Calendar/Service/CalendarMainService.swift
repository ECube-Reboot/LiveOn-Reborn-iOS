//
//  CalendarMainService.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI
import Moya

let calendarMainMoyaService = MoyaProvider<CalendarMainServerCommunication>(plugins: [NetworkLoggerPlugin()])

enum CalendarMainServerCommunication {
    case getCalendarMain(calendarRequest: String)
    case postCalendarMain(content: CalendarMainPostRequest)
    
    case getCalendarDay(calendarRequest: String)
}
