//
//  LogInEndPoint.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.

//MARK: API Endpoint로 클라이언트에서 서버에 요청하기위한 최종 사항들을 담고 있음
import Foundation
import Moya

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
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
