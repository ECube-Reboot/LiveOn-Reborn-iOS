//
//  DateToStringUpcomingEventsViewModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import Foundation

func DateToStringUpcomingEventsViewModel(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "MM/dd"
    
    let dateString = dateFormatter.string(from: date)
    
    return dateString
}

