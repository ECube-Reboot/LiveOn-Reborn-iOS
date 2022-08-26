//
//  SignInViewModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI
import Moya

class SignInViewModel: ObservableObject {
    static var signInViewModel: SignInViewModel = SignInViewModel()
    @Published var inviteCode: String = ""
  
    private let authService = AuthService()
    let signInMoyaService = MoyaProvider<AuthEndpoint>(plugins: [NetworkLoggerPlugin()])
    
    func getInviteCode() async {
        signInMoyaService.request(.getCode) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map(InviteCode.self)
                        self.fetchInviteCode(code: data.code)
                    } catch _ {
                        break
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func fetchInviteCode(code: String) {
        self.inviteCode = code
        UserDefaults.standard.set(code, forKey: "inviteCode")
    }
    
    func checkInviteCode(input: String, status: @escaping (Bool) -> ()) {
        signInMoyaService.request(.checkCode(param: input)) { response in
            switch response {
                case .success(let result):
                    if  (String(data: result.data, encoding: .utf8) == "success") {
                        status(true)
                    }
                    else{
                        status(false)
                        print("실패")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
            
        }
    }
}
