//
//  Calendar+Extension.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI

extension View {
    @ViewBuilder
    func CardView(value: CalendarModel)-> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.footnote)
                    .foregroundColor(.textBodyColor)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
        }
        .padding(.vertical, 6)
        .frame(height: UIScreen.main.bounds.height * 0.075)
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color(uiColor: .systemGray6)), alignment: .top)
    }
    
    // Checking dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extracting Year and Month for display
    func fullDate(currentDate: Date) -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func monthDate(currentDate: Date) -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func extractDate(currentDate: Date) -> [CalendarModel] {
        let calendar = Calendar.current
        
        // Getting Current Month Date
        // getCurrentMonth()
        let currentMonth = currentDate
        var days = currentMonth.getAllDates().compactMap { date -> CalendarModel in
            // getting day
            let day = calendar.component(.day, from: date)
            return CalendarModel(day: day, date: date)
        }
        
        // adding offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(CalendarModel(day: -1, date: Date()), at: 0)
        }
        return days
    }
}
