//
//  InviteCodeView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import SwiftUI

struct InviteCodeView: View {
    @ObservedObject var userData: SignInUser
    @Environment(\.dismiss) private var dismiss
    
    @State var showEnterCodeSheet: Bool = false
    @State private var showShareSheet = false
    @State var goNext: Bool = false
    @State var inviteCode: String = "나중에코드연동"
    var body: some View {
        SignInLayoutView(title: SignInLiteral.inviteCodeTitle, description: SignInLiteral.inviteCodeDescription) {
            VStack {
                
                //TODO: 코드 GET API 연동
                Text(inviteCode)
                    .font(.title)
                    .fontWeight(.heavy)
                    .textSelection(.enabled)
                    .frame(width: 268, height: 170, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color(uiColor: .systemBackground)).shadow(color: .bodyTextColor.opacity(0.3), radius: 6, x: 0, y: 2))
                    .padding(.top, 40)
                Button {
                    showShareSheet.toggle()
                }
            label: {
                copyButton
            }
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: [ MyActivityItemSource(title: SignInLiteral.inviteCodeShareSheetTitle, text: "\(userData.nickName)\(SignInLiteral.inviteCodeShareSheetText) 초대코드 : [ \(inviteCode) ]")])
            }
                
                Spacer()
                Button {
                    showEnterCodeSheet.toggle()
                }
            label: {
                Text("이미 초대코드가 있어요")
                    .fontWeight(.bold)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.lightgray))
            }
            .fullScreenCover(isPresented: $showEnterCodeSheet) {
                EnterCodeView(userData: userData)
            }
            }
            .frame(maxWidth: .infinity)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("둘러보기", destination: GiftBoxView())
                }
            }
            .navigationToBack(dismiss)
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