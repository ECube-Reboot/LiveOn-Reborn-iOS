//
//  SignInEndPoint.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/23.
//

import Foundation
import Moya

extension SignInService: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .getCode, .checkCode:
                return "/api/v1/couple/code"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getCode:
                return .get
            case .checkCode:
                return .post
        }
    }
    
    var task: Task {
        switch self {
            case .getCode:
                return .requestPlain
            case .checkCode(let code):
                return .requestJSONEncodable(code)
        }
    }
    
    var headers: [String : String]? {
        switch self {
            default:
                return ["Content-Type": "application/json",
                        "Authorization": "Bearer " + GeneralAPI.token]
        }
    }

    
    
}
