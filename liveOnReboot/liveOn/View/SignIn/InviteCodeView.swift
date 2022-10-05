//
//  InviteCodeView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import SwiftUI

struct InviteCodeView: View {
    @ObservedObject var viewModel = SignInViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State var showEnterCodeSheet: Bool = false
    @State private var showShareSheet = false
    @State var goNext: Bool = false
    @State private var inviteCodeToShow = ""
    @State private var isMatched = false
    var body: some View {
        SignInLayoutView(title: SignInLiteral.inviteCodeTitle, description: SignInLiteral.inviteCodeDescription) {
            VStack {
                NavigationLink("", destination: GiftBoxView(), isActive: $isMatched)
                //TODO: 코드 GET API 연동
                Text(UserDefaults.standard.string(forKey: "inviteCode") ?? "")
                    .font(.title)
                    .fontWeight(.heavy)
                    .textSelection(.enabled)
                    .frame(width: 268, height: 170, alignment: .center)
                    .textSelection(.enabled)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color(uiColor: .systemBackground)).shadow(color: .textBodyColor.opacity(0.3), radius: 6, x: 0, y: 2))
                    .padding(.top, 40)
                Button {
                    showShareSheet.toggle()
                }
            label: {
                copyButton
            }
            .sheet(isPresented: $showShareSheet) {
                if let code = UserDefaults.standard.string(forKey: "inviteCode") {
                ShareSheet(activityItems: [ MyActivityItemSource(title: SignInLiteral.inviteCodeShareSheetTitle, text: "\(SignInLiteral.inviteCodeShareSheetText) 초대코드 : [\(code)]")])
                }
            }
                
                Spacer()
                Text("매칭코드를 공유하셨다면, 우선 다음을 눌러 진행해주세요.")
                    .foregroundColor(.textBodyColor)
                    .opacity(0.6)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                NavigationLink(destination: InputOfficialDateView()) {
                    Text("다음")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .navigationToBack(dismiss)
        }
        .onAppear {
            if UserDefaults.standard.string(forKey: "inviteCode") == nil {
                CoupleService.getInviteCode()
            }
        }
    }
    
    var copyButton: some View {
        Text("초대코드 보내기")
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 18)
            .background( RoundedRectangle(cornerRadius: 4)
                .fill(Color.accentColor)
            )
            .padding(.top, 10)
    }
}
