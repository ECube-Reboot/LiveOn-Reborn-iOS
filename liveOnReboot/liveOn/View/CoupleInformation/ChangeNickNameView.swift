//
//  ChangeNickNameView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/25.
//

import SwiftUI

struct ChangeNickNameView: View {
    @Binding var nickNameTemp: String
    @State private var input: String = "재헌"
    @State private var showCompletionAlert = false
    @Environment(\.dismiss) private var dismiss
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
                    nickNameTemp = input
                    showCompletionAlert.toggle()
                }
                .disabled(nickNameTemp == input)
            }
        })
        .alert(isPresented: $showCompletionAlert) {
            Alert(title: Text("수정 완료"), message: Text("이제 \(nickNameTemp)님으로 불러드릴게요!"), dismissButton: .default(Text("확인")))
        }
        .navigationToBack(dismiss)
        .navigationTitle("이름 수정")
    }
}
