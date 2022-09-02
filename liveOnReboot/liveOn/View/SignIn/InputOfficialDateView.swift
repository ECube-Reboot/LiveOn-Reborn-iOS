//
//  InputOfficialDateView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import SwiftUI

struct InputOfficialDateView: View {
    @ObservedObject var userData: SignInUser
    @Environment(\.dismiss) private var dismiss
    
    @State var officialDate = Date.now
    @State var goNext: Bool = false
    
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
            NavigationLink("", destination: InviteCodeView(userData: self.userData), isActive: $goNext)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("다음"){
                    userData.officialDay = self.officialDate
                   MemberConfigService.postMemeberInformation(
                        information: PostMemberInformationDTO(birthDay: userData.birthDay.toString(dateFormat: "YYYY-MM-dd"),
                                                              nickName: userData.nickName,
                                                              officialDay: userData.officialDay.toString(dateFormat: "YYYY-MM-dd"))
                    ) {
                        UserStatus.updateUserStatus(status: UserStatus.informationEntered)
                        goNext.toggle()
                    }
                }
            }
        }
        .navigationToBack(dismiss)
    }
}

struct InputOfficialDateView_Previews: PreviewProvider {
    static var previews: some View {
        InputOfficialDateView(userData: SignInUser())
    }
}
