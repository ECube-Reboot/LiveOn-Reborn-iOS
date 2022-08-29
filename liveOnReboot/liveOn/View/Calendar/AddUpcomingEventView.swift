//
//  AddUpcomingEventView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/17.
//

import SwiftUI

struct AddUpcomingEventView: View {
    @State var placeholderText: String = "메모를 입력해주세요."
    
    @Binding var upcomingEventDate: Date
    @Binding var upcomingEventBaseDate: Date
    @Binding var upcomingEventTitle: String
    @Binding var upcomingEventMemo: String
    
    @EnvironmentObject var store: CalendarViewModel
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            header
            
            DatePicker("기념일 추가", selection: $upcomingEventBaseDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .accentColor(.black)
                .applyTextColor(.burgundy)
                .background(Color.backgroundGray.cornerRadius(30))
                .frame(width: UIScreen.main.bounds.width * 0.88, height: UIScreen.main.bounds.height * 0.4)

            footer
            
            Spacer()
        }
        .padding(.vertical)
    }
    
    var header: some View {
        HStack(alignment: .center, spacing: 0) {
            Button("취소") {
                upcomingEventBaseDate = Date.now
                dismiss()
            }
            .font(.title3)
            .foregroundColor(.burgundy)
            
            Spacer()
            
            Text("기념일 추가")
                .font(.title3.bold())
                .foregroundColor(.burgundy)
            
            Spacer()
            
            Button("확인") {
                upcomingEventDate = self.upcomingEventBaseDate
                store.insert(upcomingEventDate: upcomingEventDate, upcomingEventTitle: upcomingEventTitle, upcomingEventMemo: upcomingEventMemo)
                store.calendarMainPost(upcomingEventdate: DateToStringUpcomingEventsViewModel(upcomingEventDate), upcomingEventTitle: upcomingEventTitle, upcomingEventMemo: upcomingEventMemo)
                upcomingEventBaseDate = Date.now
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title3)
            .foregroundColor(.burgundy)
        }
        .padding([.trailing, .leading], 20)
    }
    
    var footer: some View {
        VStack {
            TextField("upcomingEventTitle", text: $upcomingEventTitle, prompt: Text("어떤 기념일인가요?"))
                .multilineTextAlignment(.leading)
                .padding(.leading, 10)
                .frame(width: 345, height: 40)
                .foregroundColor(.textBodyColor)
                .font(.body)
                .background(Color.backgroundGray.cornerRadius(6))
                .padding(.top, 15)
            ZStack {
                if upcomingEventMemo.isEmpty {
                    TextEditor(text: $placeholderText)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 7)
                        .font(.body)
                        .foregroundColor(Color(UIColor.systemGray3))
                        .padding(.top, 5)
                }
                TextEditor(text: $upcomingEventMemo)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 7)
                    .font(.body)
                    .foregroundColor(.textBodyColor)
                    .lineSpacing(5)
                    .padding(.top, 5)
            }
            .onAppear() {
                UITextView.appearance().backgroundColor = .clear
            }
            .onDisappear() {
                UITextView.appearance().backgroundColor = nil
            }
            .background(Color.backgroundGray.cornerRadius(6))
            .frame(width: 345, height: 124)
            .padding(.top, 15)
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

#if canImport(UIKit)
extension View {
    func downKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct PlusSetting_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(CalendarViewModel())
    }
}
