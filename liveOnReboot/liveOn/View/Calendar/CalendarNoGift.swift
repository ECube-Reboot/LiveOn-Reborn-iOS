//
//  CalendarNoGift.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/08/25.
//

import SwiftUI

struct CalendarNoGift: View {
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
            }
            eventSection
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var eventSection: some View {
        VStack {
            Image("LoadingCharacter")
                .padding(.bottom, 20)
            Text("어떤 선물이 오고 있을까요?")
                .foregroundColor(.textBodyColor)
                .font(.title3)
        }
    }
}


struct CalendarNoGift_Previews: PreviewProvider {
    static var previews: some View {
        CalendarNoGift(date: Date.now)
    }
}
