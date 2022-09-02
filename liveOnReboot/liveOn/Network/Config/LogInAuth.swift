//
//  LogInAuth.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/18.
//

import Foundation
import Moya
import UIKit

class AuthNetworkService {
    let authProvider = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    func login(accessToken: String) -> String {
        var tokenResponse = LoginResponseDTO(accessToken: "", isNewMember: false, refreshToken: "", userSettingDone: false)
        let param = LoginRequestDTO.init(accessToken: accessToken)
        authProvider.request(.login(request: param)) { response in
            switch response {
            case .success(let result):
                print(result)
                tokenResponse = try! result.map(LoginResponseDTO.self)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        return tokenResponse.accessToken
    }
}
