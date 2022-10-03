//
//  ChangeOfficialDateView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/25.
//

import SwiftUI

struct ChangeOfficialDateView: View {
    @Binding var officialDay: Date
    // 임시, 나중에 서버 연동후에 데이터는 제대로 관리할 예정
    @State private var tempSelection: Date = Date().stringDateToDateFormat(MemberConfigService.singleton.profile.officialDate)
    @State private var showCompletionAlert = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Text("\(tempSelection.toString(dateFormat: "YYYY년 M월 d일"))")
                .font(.TextStyles.handWrittenTitle)
                .foregroundColor(.textBodyColor)
                .padding(.horizontal)
                .background(Image("highlightDate_yellow").resizable().frame(height: 10, alignment: .bottomLeading).offset(y: 10))
                .frame(maxWidth: .infinity, alignment: .bottom)
            DatePicker("officialDay", selection: $tempSelection, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(20)
        .background(Color.backgroundGray)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장"){
                    CoupleService.patchOfficialDate(officialDate: OfficialDate(officialDate: tempSelection.toServerFormatString())) {
                        if CoupleService.singleton.isSuccessed {
                            showCompletionAlert.toggle()
                        }
                    }
                }
                .disabled(officialDay == tempSelection)
            }
        })
        .alert(isPresented: $showCompletionAlert) {
            Alert(title: Text("1일 수정 완료"),
                  message: Text("\(tempSelection.toServerFormatString())으로 정확하게 입력해둘게요!"),
                  dismissButton: .default(Text("확인")) {
                MemberConfigService.fetchMemberProfile {
                    dismiss()
                }
            }
            )
        }
        .navigationToBack(dismiss)
        .navigationTitle("1일 날짜 수정")
    }
}
