//
//  Date+Extension.swift
//  liveOnReboot
//

import Foundation

// Extending Date to get Current Month Dates
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
    
    public func stringDateToDateFormat(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.date(from: date) ?? Date.now
    }
    
    public func eventDateToString(_ format: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: format)
    }
    
    public func monthEnglishToString(_ format: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: format)
    }
    
    public func monthToString(_ format: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: format)
    }
    
    
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // getting start Date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // getting date
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    func countDays() -> Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: self, to: Date()).day! + 1
    }
    
    func toServerFormatString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func toServerFormatEventDateString(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        if let temp = dateFormatter.date(from: date) {
            return Date().eventDateToString(temp) }
        else { return "" }
    }
    
}
