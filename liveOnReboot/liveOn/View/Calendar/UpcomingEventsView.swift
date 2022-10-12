//
//  UpcomingEventsView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI

struct UpcomingEventsView: View {
    let event: EventResponseList
    var body: some View {
        
        HStack(alignment: .top) {
            //  upcomingEventDate
            Text(Date().toServerFormatEventDateString(date: event.upcomingEventDate))
                .font(.body)
                .foregroundColor(.textBodyColor)
                .background(Image("highlightForCalendar").resizable().frame(height: 10, alignment: .bottomLeading).offset(y: 5))
                .scaledToFill()
                .frame(maxHeight: .infinity, alignment: .top)
            VStack(spacing: 4) {
                //  upcomingeventTitle
                Text(event.upcomingEventTitle)
                    .foregroundColor(.textBodyColor)
                    .font(.body.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // upcomingeventMemo
                Text(event.upcomingEventMemo)
                    .foregroundColor(.textBodyColor)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.06)
            .padding(.leading, 4)
        }
        .padding(.vertical)
        .background(RoundedRectangle(cornerRadius: 15)
            .fill(Color.backgroundGray))
        .frame(maxHeight: UIScreen.main.bounds.width * 0.16)
        .padding(.vertical)
    }
}
