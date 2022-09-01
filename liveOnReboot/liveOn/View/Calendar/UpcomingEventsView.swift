//
//  UpcomingEventsView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI
// Test용으로 넣어 놓은거고 UI에 맞게 수정할 예정
struct UpcomingEventsView: View {
    let event: UpcomingEventsModel
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.backgroundGray)
                    .frame(width: 360, height: 65)
                
                    HStack {
                        //  upcomingEventDate
                        Text(event.upcomingEventDate)
                            .font(.body)
                            .foregroundColor(.textBodyColor)
                    }
                    .padding(.leading, -170)
                    .padding(.top, -20)
                
                Image("highlightForCalendar")
                    .padding(.leading, -165)
                    .padding(.top, -14)
                
                    VStack {
                        //  upcomingeventTitle
                        Text(event.upcomingEventTitle)
                            .foregroundColor(.textBodyColor)
                            .font(.title3.bold())
                            .frame(width: 280, alignment: .leading)
                            .padding(.trailing, -35)
                        
                        // upcomingeventMemo
                        Text(event.upcomingEventMemo)
                            .foregroundColor(.textBodyColor)
                            .font(.body)
                            .frame(width: 280, alignment: .leading)
                            .padding(.trailing, -35)
                            .padding(.top, -8)
                    }
            }
        }
    }
}

