//
//  InputOfficialDateView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import SwiftUI

struct InputOfficialDateView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var officialDate = Date.now
    @State var goNext: Bool = false
    @State private var showAlert: Bool = false
    var body: some View {
        SignInLayoutView(title: SignInLiteral.inputOfficailDateTitle, description: SignInLiteral.inputOfficailDateDescription) {
            VStack {
                VStack {
                    VStack {
                        Text("\(officialDate.toString(dateFormat: "YYYY년 M월 d일"))")
                            .font(.TextStyles.handWrittenTitle)
                            .foregroundColor(.textBodyColor)
                            .padding(.horizontal)
                            .background(Image("highlightDate_red").resizable().frame(height: 10, alignment: .bottomLeading).offset(y: 10).opacity(0.5))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .top)
                DatePicker("officialDate", selection: $officialDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            NavigationLink("", destination: GiftBoxView(), isActive: $goNext)
        }
        .alert(isPresented: $showAlert){
            Alert(title: Text("실패"), message: Text("문제가 생겼어요 다시 시도해주세요🥲"), dismissButton: .cancel())
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("다음"){
                    CoupleService.postOfficialDate(officialDate: OfficialDate(officialDate: self.officialDate.toServerFormatString())) {
                        if CoupleService.singleton.isSuccessed {
                            goNext.toggle()
                            CoupleService.singleton.isSuccessed.toggle()
                        } else {
                            showAlert.toggle()
                        }
                    }
                }
            }
        }
        .navigationToBack(dismiss)
    }
}

struct InputOfficialDateView_Previews: PreviewProvider {
    static var previews: some View {
        InputOfficialDateView()
    }
}
