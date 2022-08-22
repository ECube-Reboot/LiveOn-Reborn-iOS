//
//  WelcomMatchingView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/18.
//

import SwiftUI

struct WelcomMatchingView: View {
    @ObservedObject var userData: SignInUser
    var body: some View {
        SignInLayoutView(title: SignInLiteral.welcomMatchingTitle, description: SignInLiteral.welcomMatchingDescription) {
            VStack {
                Image(SignInLiteral.welcomMatchingImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width*0.5, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .center)
            NavigationLink(destination: GiftBoxView())
            { Text("시작하기")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center).background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
            }
            .buttonStyle(.plain)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct WelcomMatchingView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomMatchingView(userData: SignInUser())
    }
}
