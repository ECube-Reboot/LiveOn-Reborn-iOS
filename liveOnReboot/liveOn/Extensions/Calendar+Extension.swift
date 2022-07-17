//
//  Calendar+Extension.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func CardView(value: CalendarModel)->some View {
        
        VStack {
            
            if value.day != -1 {
                
                Text("\(value.day)")
                    .font(.system(size: 13))
                    .foregroundColor(.textBodyColor)
                    .frame(width: 18, height: 18, alignment: .center)
                    .padding(2)
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 2)
                
                Spacer()
            }
        }
        .padding(.vertical, 6)
        .frame(height: 80)
        .border(Color(uiColor: .systemGray3), width: 0.16)
    }
    
    // Checking dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extrating Year and Month for display
    func extraDate(currentDate: Date) -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func extractDate(currentDate: Date) -> [CalendarModel] {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        let currentMonth = currentDate // getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> CalendarModel
            in
            
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
