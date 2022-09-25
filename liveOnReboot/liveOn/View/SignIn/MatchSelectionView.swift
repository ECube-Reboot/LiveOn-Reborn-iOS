//
//  MatchSelectionView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/09/25.
//

import SwiftUI

struct MatchSelectionView: View {
    var body: some View {
        SignInLayoutView(title: "상대와 함께하기", description: "선물함은 함께 채워나가야죠! 함께할 상대와 만나봐요!") {
            VStack {
                NavigationLink(destination: InviteCodeView(userData: SignInUser())) {
                    ActionButton(description: "상대방을 초대할게요", label: "초대코드 생성")
                }
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                    Text("or")
                        .padding()
                    Rectangle()
                        .frame(height: 1)
                }
                NavigationLink(destination: EnterCodeView(userData: SignInUser())) {
                    ActionButton(description: "상대방에게 초대받았어요", label: "초대코드 입력")
                }
            }
        }
    }
}
extension MatchSelectionView {
    struct ActionButton: View {
        let description: String
        let label: String
        
        var body: some View {
            VStack(alignment: .center, spacing: 4) {
                Text(description)
                    .opacity(0.6)
                    .frame(maxWidth: .infinity)
                Text(label)
                    .bold()
            }
            .padding()
            .frame(height: 80)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke()
            )
            
        }
    }
}

struct MatchSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MatchSelectionView()
    }
}
