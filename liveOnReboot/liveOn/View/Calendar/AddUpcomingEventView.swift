//
//  AddUpcomingEventView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI

struct AddUpcomingEventView: View {
    
    @State private var showani = false
    @State var show = false
    
    @Binding var upcomingEventDate: Date
    @Binding var upcomingEventBaseDate: Date
    @Binding var upcomingEventTitle: String
    @Binding var upcomingEventMemo: String
    
    @EnvironmentObject var store: EventStore
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                Button("취소") {
                    upcomingEventBaseDate = Date.now
                    dismiss()
                }
                .font(.callout)
                .foregroundColor(.burgundy)

                Spacer()
                
                Text("기념일 추가")
                    .font(.title2.bold())
                    .foregroundColor(.burgundy)

                Spacer()
                
                Button("확인") {
                    upcomingEventDate = self.upcomingEventBaseDate
                    store.insert(upcomingEventDate: upcomingEventDate, upcomingEventTitle: upcomingEventTitle, upcomingEventMemo: upcomingEventMemo)
                    upcomingEventBaseDate = Date.now
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.callout)
                .foregroundColor(.burgundy)
            }
            .padding([.trailing, .leading], 15)
            .padding(.top, -205)
            
            DatePicker("기념일 추가", selection: $upcomingEventBaseDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .accentColor(.black)
//                .applyTextColor(.burgundy)
                .padding(.top, -190)
            
            TextField("Comment", text: $upcomingEventTitle, prompt: Text("어떤 기념일인가요?"))
                .multilineTextAlignment(TextAlignment.leading)
                .foregroundColor(.textBodyColor)
                .frame(width: 250, height: 20)
                .font(.system(size: 18))
            
            Text("(\(upcomingEventTitle.count)/15)")
                .frame(width: 300, height: 20, alignment: .trailing)
                .foregroundColor(.textBodyColor).opacity(0.5)
            
            TextField("Comment", text: $upcomingEventMemo, prompt: Text("메모를 입력해주세요."))
                .multilineTextAlignment(TextAlignment.leading)
                .foregroundColor(.textBodyColor)
                .frame(width: 250, height: 20)
                .font(.system(size: 18))
            
            Text("(\(upcomingEventMemo.count)/20)")
                .frame(width: 300, height: 20, alignment: .trailing)
                .foregroundColor(.textBodyColor).opacity(0.5)
        }
    }
}

struct PlusSetting_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(EventStore())
    }
}
