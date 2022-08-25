//
//  CalendarGiftBox.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/08/24.
//

import SwiftUI

struct CalendarGiftBox: View {
    @State var date: Date
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(Date().eventDateToString(date))")
                    .font(.TextStyles.largeCalendarNumber)
                    .foregroundColor(.textBodyColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    eventSection
                    
                    Image("flowerIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 220, height: 200, alignment: .center)
                    
                    Image("letter_purple")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 200, alignment: .center)
                    
                    Image("casetteIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 200, alignment: .center)
                    
                    Image("photocardIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 200, alignment: .center)
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var eventSection: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.backgroundGray)
                    .frame(width: 360, height: 65)
                
                    HStack {
                        //  upcomingEventDate
                        Text("08/26")
                            .font(.body)
                            .foregroundColor(.textBodyColor)
                            .background(Image("highlightForCalendar"))
                            .scaledToFill()
                    }
                    .padding(.leading, -170)
                    .padding(.top, -20)
                
                    VStack {
                        //  upcomingeventTitle
                        Text("삼겹살 먹는 날")
                            .foregroundColor(.textBodyColor)
                            .font(.title3.bold())
                            .frame(width: 280, alignment: .leading)
                            .padding(.trailing, -35)
                        
                        // upcomingeventMemo
                        Text("영일대 맛찬들가서 삼겹살 + 소주 때리기")
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

struct CalendarGiftBox_Previews: PreviewProvider {
    static var previews: some View {
            CalendarGiftBox(date: Date.now)
    }
}
