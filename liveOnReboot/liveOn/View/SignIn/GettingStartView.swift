//
//  FirstView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import SwiftUI
import Moya
import AuthenticationServices

struct GettingStartView: View {
    @ObservedObject var appleSignInViewModel: AppleSignInViewModel = AppleSignInViewModel()
    @State private var authenticationData: String = ""
    @State private var isActive: Bool = false
    
    let authProvider = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                
                Group {
                    // TODO: 이미지 넣기
                    Image("appIconImg")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.vertical)
                    Text("하루에 하나씩,\n기념일을 기념하기")
                        .foregroundColor(.textBodyColor)
                    Text("live'On")
                        .foregroundColor(.mainBrown)
                        .font(.system(size: 46))
                        .fontWeight(.heavy)
                }
                .padding(.leading, 20)
                Spacer()
                    .frame(height: 120, alignment: .center)
                NavigationLink(destination: InputNickNameView(), isActive: $isActive) {
                    Text("")
                }
                SignInWithAppleButton(.signIn, onRequest: { request in request.requestedScopes = []
                }, onCompletion: { result in
                    authenticationData = appleSignInViewModel.didFinishAppleSignin(result: result)
//                    isActive.toggle()
                })
                .frame(width: 280, height: 60)
                .padding(.top, 50)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.backgroundGray)
    }
}

struct GettingStart_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartView(appleSignInViewModel: AppleSignInViewModel())
    }
}
