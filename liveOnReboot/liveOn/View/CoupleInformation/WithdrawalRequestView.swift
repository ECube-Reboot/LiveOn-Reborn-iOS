//
//  WithdrawalRequestView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/25.
//

import SwiftUI

struct WithdrawalRequestView: View {
    @State private var confirmCheck = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("회원탈퇴하시겠어요?")
                .font(.title)
                .fontWeight(.bold)
            Text("상대와의 연결이 끊어집니다. \n다음 유의 사항을 꼭 읽어주세요")
            
            VStack(alignment: .leading, spacing: 16) {
                Text("• 회원탈퇴 신청 후 상대방과의 연결은 즉시 해제됩니다.")
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Text("• 주고받은 선물 및 회원정보는 탈퇴 후 30일의 유예기간 후 삭제됩니다.")
                Text("• 탈퇴 30일 전 다시 로그인하면 회원탈퇴를 취소할 수 있습니다.")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.lightgray)
            
            NavigationLink(destination: GettingStartView())
            { Text("탈퇴하기")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center).background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
            }
            .buttonStyle(.plain)
        }
        .foregroundColor(.textBodyColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(20)
        .background(Color.backgroundGray)
    }
}

struct WithdrawalRequestView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawalRequestView()
    }
}
