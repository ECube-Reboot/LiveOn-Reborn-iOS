//
//  EnterCodeView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import SwiftUI

struct EnterCodeView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userData: SignInUser
    @State var code: String = ""
    @State var checkCode: Bool = false
    @State var presentFailAlert: Bool = false
    @ObservedObject var viewModel = SignInViewModel()
    @State private var goNext: Bool = false
    
    var body: some View {
            SignInLayoutView(title: SignInLiteral.enterCodeTitle, description: SignInLiteral.enterCodeDescription) {
                VStack {
                    TextField(SignInLiteral.enterCodePlaceholder, text: $code)
                                            .font(.title)
                                            .limitInputLength(value: $code, length: 5)
                                            .multilineTextAlignment(.center)
                                            .padding(16)
                    Spacer()
                    NavigationLink("", destination: WelcomMatchingView(userData: userData), isActive: $checkCode)
                }
                    // MARK: 코드 확인
                    Button {
                        CoupleService.checkInviteCode(input: code) { result in
                            checkCodeMatched(status: result)
                            if result {
                                UserDefaults.standard.set(true, forKey: "isMatched")
                                UserStatus.updateUserStatus(status: UserStatus.allSettingFinished)
                                goNext = true
                            }
                        }
                    }
                label: {
                    Text("초대코드 확인")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center).background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
                }
                .alert(isPresented: $presentFailAlert) {
                    Alert(title: Text("매칭 실패"), message: Text("초대코드를 다시 확인해주세요"), dismissButton: .default(Text("확인")){
                        presentFailAlert = false
                    }
                )}
                .disabled(code.count != 5)
                NavigationLink("", destination: WelcomMatchingView(userData: userData), isActive: $goNext)
            }
                .frame(maxHeight: .infinity)
                .navigationToBack(dismiss)
    }
    func isCorrect(userCode: String) -> Bool {
        return self.code == userCode
    }
    private func checkCodeMatched(status: Bool) {
        presentFailAlert = !status
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView(userData: SignInUser())
    }
}
