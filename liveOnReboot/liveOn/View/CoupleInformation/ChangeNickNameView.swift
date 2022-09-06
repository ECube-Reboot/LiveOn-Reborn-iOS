//
//  ChangeNickNameView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/25.
//

import SwiftUI

struct ChangeNickNameView: View {
    @State private var input: String = MemberConfigService.singleton.profile.currentUserName
    @State private var showCompletionAlert = false
    @Environment(\.dismiss) private var dismiss
    init() {
        self.input = MemberConfigService.singleton.profile.currentUserName
    }
    var body: some View {
        VStack(alignment: .leading){
            Text("이름")
            //TODO: UserName 연동하기
            TextField(SignInLiteral.inputNickNamePlaceHolder, text: $input)
                .limitInputLength(value: $input, length: textLimit.nickName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.lightgray))
            Text("(\(input.count)/\(textLimit.nickName))")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .opacity(0.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(20)
        .background(Color.backgroundGray)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장"){
                    MemberConfigService.editNickName(currentNickName: input) {
                        showCompletionAlert.toggle()
                    }
                }
                .disabled(MemberConfigService.singleton.profile.currentUserName == input)
            }
        })
        .alert(isPresented: $showCompletionAlert) {
            Alert(title: Text("수정 완료"),
                  message: Text("이제 \(input)님으로 불러드릴게요!"),
                  dismissButton: .default(Text("확인")) {
                MemberConfigService.fetchMemberProfile {
                    dismiss()
                }
                
            }
            )
        }
        .navigationToBack(dismiss)
        .navigationTitle("이름 수정")
    }
}
