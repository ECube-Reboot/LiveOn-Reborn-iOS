//
//  AuthEndPoint.swift
//  liveOnReboot
//
//  Created by Jihye Hong on 2022/08/26.
//

import Foundation
import Moya

enum AuthEndpoint {
    case login(request: LoginRequestDTO)
}

extension AuthEndpoint: TargetType {
    var baseURL: URL {
        return URL(string: API.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "api/v1/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let loginRequestDTO):
            return .requestJSONEncodable(loginRequestDTO)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
