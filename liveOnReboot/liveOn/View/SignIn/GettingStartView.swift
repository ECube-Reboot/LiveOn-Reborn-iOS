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
    @State private var isActive: Bool = false
    
    let authProvider = MoyaProvider<AuthEndpoint>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
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
                    Text("하루에 하나씩,\n너에게 보내는 선물")
                        .foregroundColor(.textBodyColor)
                        .font(.TextStyles.handWrittenBody)
                    Text("Dear, you")
                        .foregroundColor(.mainBrown)
                        .font(.TextStyles.largeCalendarNumber)
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
                    switch result {
                        case .success:
                            UserStatus.updateUserStatus(status: UserStatus.appleSignInFinished)
                            appleSignInViewModel.didFinishAppleSignin(result: result)
                            isActive.toggle()
                        case .failure:
                            return
                    }
                })
                .frame(width: 280, height: 60)
                .padding(.top, 50)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.backgroundGray)
        .navigationBarBackButtonHidden(true)
    }
}

struct GettingStart_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartView(appleSignInViewModel: AppleSignInViewModel())
    }
}
