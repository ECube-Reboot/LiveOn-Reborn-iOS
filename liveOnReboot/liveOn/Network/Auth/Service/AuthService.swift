//
//  LoginService.swift
//  liveOnReboot
//
//  Created by Jihye Hong on 2022/08/26.
//

import Foundation
import Moya
import SwiftUI

class AuthService: ObservableObject {
    let authProvider = MoyaProvider<AuthEndpoint>(plugins: [NetworkLoggerPlugin(verbose: true)])
    @ObservedObject static var shared = AuthService()
    @Published var userSetting = false
    func login(accessToken: String, group: DispatchGroup) {
        var tokenResponse = LoginResponseDTO(accessToken: "", isNewMember: false, refreshToken: "", userSettingDone: false)
        
        let param = LoginRequestDTO.init(accessToken: accessToken)
        
        authProvider.request(.login(request: param)) { response in
            switch response {
            case .success(let result):
                tokenResponse = try! result.map(LoginResponseDTO.self)
                AuthService.shared.userSetting = tokenResponse.userSettingDone
                KeyChain.create(key: "accessToken", token: tokenResponse.accessToken)
                KeyChain.create(key: "refreshToken", token: tokenResponse.refreshToken)
                group.leave()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
