//
//  MatchSelectionView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/09/25.
//

import SwiftUI

struct MatchSelectionView: View {
    var body: some View {
        SignInLayoutView(title: "상대와 만나기", description: "선물함은 함께 채워나가야죠! 함께할 상대와 만나봐요!") {
            VStack {
                NavigationLink(destination: InviteCodeView()) {
                    ActionButton(description: "상대방을 초대할게요", label: "초대코드 생성", image: "createBox")
                }
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                    Text("or")
                        .padding()
                    Rectangle()
                        .frame(height: 1)
                }
                .opacity(0.6)
                NavigationLink(destination: EnterCodeView(userData: SignInUser())) {
                    ActionButton(description: "상대방에게 초대받았어요", label: "초대코드 입력", image: "enterCode")
                }
            }
        }
    }
}
extension MatchSelectionView {
    struct ActionButton: View {
        let description: String
        let label: String
        let image: String
        
        var body: some View {
            HStack(alignment: .center, spacing: 8) {
                Spacer()
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 44, maxHeight: 44)
                VStack(alignment: .leading, spacing: 4) {
                    Text(description)
                        .opacity(0.6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text(label)
                            .bold()
                }
                Spacer()
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
