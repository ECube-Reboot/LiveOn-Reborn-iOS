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
    case postMemberInformation(param: PostMemberInformationDTO)
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
        case .postMemberInformation:
            return  "/api/v1/member"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .login, .checkCode, .postMemberInformation:
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
            case .postMemberInformation(let information):
                return .requestJSONEncodable(information)
        }
        
    }
    
    var headers: [String: String]? {
        switch self {
            case .login:
                return ["Content-Type": "application/json"]
            default:
                return ["Content-Type": "application/json",
                        "Authorization": GeneralAPI.token()]
        }
    }
}
