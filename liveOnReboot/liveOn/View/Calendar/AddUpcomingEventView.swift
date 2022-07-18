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
            
            DatePicker("기념일 추가", selection: $upcomingEventBaseDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .accentColor(.black)
                .background(Color.backgroundGray.cornerRadius(30))
                .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.4)
            
            // Test용으로 넣어놓은 거고 아래 코드는 UI에 맞게 수정할 예정
            //            TextField("Comment", text: $upcomingEventTitle, prompt: Text("어떤 기념일인가요?"))
            //                .multilineTextAlignment(TextAlignment.leading)
            //                .foregroundColor(.textBodyColor)
            //                .frame(width: 250, height: 20)
            //                .font(.body)
            //
            //            Text("(\(upcomingEventTitle.count)/20)")
            //                .frame(width: 300, height: 20, alignment: .trailing)
            //                .foregroundColor(.textBodyColor).opacity(0.5)
            //
            //            TextField("Comment", text: $upcomingEventMemo, prompt: Text("메모를 입력해주세요."))
            //                .multilineTextAlignment(TextAlignment.leading)
            //                .foregroundColor(.textBodyColor)
            //                .frame(width: 250, height: 20)
            //                .font(.body)
            //
            //            Text("(\(upcomingEventMemo.count)/20)")
            //                .frame(width: 300, height: 20, alignment: .trailing)
            //                .foregroundColor(.textBodyColor).opacity(0.5)
        }
        .padding(.top, -330)
    }
}

struct PlusSetting_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(EventStore())
    }
}
