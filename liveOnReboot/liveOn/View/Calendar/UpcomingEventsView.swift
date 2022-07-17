//
//  UpcomingEventsView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI
// Test용으로 넣어 놓은거고 UI에 맞게 수정할 예정
struct UpcomingEventsView: View {
    let event : UpcomingEventsModel
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.backgroundGray)
                    .frame(width: 355, height: 66)
                
                    VStack {
                        //  upcomingEventDate
                        Text(event.upcomingEventDate)
                            .font(.system(size: 13))
                            .foregroundColor(.burgundy)
                    }
                    .padding(.leading, -21)
                    
                    VStack {
                        //  upcomingeventTitle
                        Text(event.upcomingEventTitle)
                            .foregroundColor(.black)
                            .font(.system(size: 18).bold())
                            .frame(width: 280, alignment: .leading)
                            .padding(.trailing, -30)
                            .padding(.bottom, 3)
                        
                        // upcomingeventMemo
                        Text(event.upcomingEventMemo)
                            .foregroundColor(.textBodyColor)
                            .font(.system(size: 14))
                            .frame(width: 280, alignment: .leading)
                            .padding(.trailing, -32)
                    }
                    .padding(.leading, 6)
            }
            .padding(.top, 2)
        }
    }
}

