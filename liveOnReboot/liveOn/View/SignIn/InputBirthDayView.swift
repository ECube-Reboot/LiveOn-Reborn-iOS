//
//  InputBirthDayView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import SwiftUI

struct InputBirthDayView: View {
    @ObservedObject var userData: SignInUser
    @Environment(\.dismiss) private var dismiss
    
    @State var birthday = Date.now
    @State var goNext: Bool = false
    
    var body: some View {
        SignInLayoutView(title: "\(userData.nickName)님의 \(SignInLiteral.inputBirthDayTitle)", description: SignInLiteral.inputBirthDayDescription) {
            VStack {
                Text("\(birthday.toString(dateFormat: "YYYY년 M월 d일"))")
                    .font(.TextStyles.handWrittenTitle)
                    .foregroundColor(.textBodyColor)
                    .padding(.horizontal)
                    .background(Image("highlightDate_yellow").resizable().frame(height: 10, alignment: .bottomLeading).offset(y: 10))
                    .frame(maxWidth: .infinity, alignment: .bottom)
                DatePicker("birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            NavigationLink("", destination: MatchSelectionView(), isActive: $goNext)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("다음"){
                    userData.birthDay = self.birthday
                    goNext.toggle()
                }
            }
        }
        .navigationToBack(dismiss)
    }
}

struct InputBirthDayView_Previews: PreviewProvider {
    static var previews: some View {
        InputBirthDayView(userData: SignInUser())
    }
}
