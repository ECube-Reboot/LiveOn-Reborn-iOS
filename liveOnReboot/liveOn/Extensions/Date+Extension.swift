//
//  Date+Extension.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/07/26.
//

import Foundation

extension Date {
  public func dateToString(_ format: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYMMdd"
    return dateFormatter.string(from: format)
  }
  
  public func stringDateToFormat(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    return dateToString(dateFormatter.date(from: date)!)
  }
}
