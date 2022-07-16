//
//  Config.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.
//
//MARK: 로그인 NetworkService 제공
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

struct GeneralAPI {
    static let baseURL = "http://13.124.90.96:8080"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdHJpbmciLCJyb2xlIjoiVVNFUiIsImV4cCI6MTY1ODIxNTgwMSwiaWF0IjoxNjU1NjIzODAxfQ.grBYdobpNbQ80e-OdqAED0DD-jjRF10a-vaKam06fHk"
}
