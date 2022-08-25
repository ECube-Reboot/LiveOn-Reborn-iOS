//
//  SignInViewModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    static var signInViewModel: SignInViewModel = SignInViewModel()
    @Published var inviteCode: String = ""
  
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
}
