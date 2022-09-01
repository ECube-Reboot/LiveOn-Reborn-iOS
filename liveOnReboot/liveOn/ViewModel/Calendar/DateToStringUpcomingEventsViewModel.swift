//
//  DateToStringUpcomingEventsViewModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import Foundation

func DateToStringEventMonth(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    
    let dateString = dateFormatter.string(from: date)
    
    return dateString
}

func DateToStringEvent(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    
    let dateString = dateFormatter.string(from: date)
    
    return dateString
}

func StringToDateEvent(strDate: String, format: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: strDate)!
}


