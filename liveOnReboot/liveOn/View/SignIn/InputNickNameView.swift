//
//  InputNickNameView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import SwiftUI

struct InputNickNameView: View {
    @ObservedObject var userData = SignInUser()
    @State var input: String = ""
    @State var goNext: Bool = false
    var body: some View {
        SignInLayoutView(title: SignInLiteral.inputNickNameTitle, description: SignInLiteral.inputNickNameDescription) {
            TextField(SignInLiteral.inputNickNamePlaceHolder, text: $input)
                .limitInputLength(value: $input, length: textLimit.nickName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.lightgray))
            Text("(\(input.count)/\(textLimit.nickName))")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .opacity(0.5)
            NavigationLink("", destination: InputBirthDayView(userData: self.userData), isActive: $goNext)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("다음"){
                    userData.nickName = self.input
                    goNext.toggle()
                }
                .disabled(input.isEmpty)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct InputNickNameView_Previews: PreviewProvider {
    static var previews: some View {
        InputNickNameView()
    }
}
