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
    case getCode
    case checkCode(param: String)
}

extension AuthEndpoint: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "api/v1/auth/login"
        case .getCode, .checkCode:
            return "/api/v1/couple/code"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .login, .checkCode:
                return .post
            case .getCode:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case .login(let loginRequestDTO):
                return .requestJSONEncodable(loginRequestDTO)
            case .getCode:
                return .requestPlain
            case .checkCode(let code):
                return .requestJSONEncodable(code)
        }
        
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
