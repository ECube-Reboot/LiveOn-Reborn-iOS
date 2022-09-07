//
//  PopupDate.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI

struct PopupDate: View {
    
    @State var popupDate: Date = Date()
    
    @Binding var currentDate: Date
    @Binding var showDatePicker: Bool
    @Binding var popUpBoolean: Bool
    @Binding var isClicked: Bool

    var body: some View {
        ZStack {
            VStack {
                DatePicker("PopUp", selection: $popupDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .applyTextColor(.burgundy)
                    .accentColor(.black)
                                
                HStack {
                    Button("취소") {
                        showDatePicker = false
                        isClicked.toggle()
                    }
                    .font(.system(size: 18).bold())
                    .foregroundColor(.burgundy)
                    .padding(.top, -20)
                    
                    Spacer()
                    
                    Button("확인") {
                        self.currentDate = popupDate
                        showDatePicker = false
                        isClicked.toggle()
                    }
                    .font(.system(size: 18).bold())
                    .foregroundColor(.burgundy)
                    .padding(.top, -20)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .background(Color.backgroundGray.cornerRadius(30))
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.36, alignment: .center)
        .padding(.top, -540)
    }
}
