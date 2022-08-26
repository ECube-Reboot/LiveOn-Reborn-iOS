//
//  LoginService.swift
//  liveOnReboot
//
//  Created by Jihye Hong on 2022/08/26.
//

import Foundation

import Foundation
import Moya
import UIKit

class AuthService {
    let authProvider = MoyaProvider<AuthEndpoint>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func login(accessToken: String) -> Void {
        var tokenResponse = LoginResponseDTO(accessToken: "", isNewMember: false, refreshToken: "", userSettingDone: false)
        
        let param = LoginRequestDTO.init(accessToken: accessToken)
        
        authProvider.request(.login(request: param)) { response in
            switch response {
            case .success(let result):
                tokenResponse = try! result.map(LoginResponseDTO.self)
                print(tokenResponse.accessToken)
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
