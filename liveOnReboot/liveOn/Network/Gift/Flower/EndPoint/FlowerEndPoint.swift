//
//  FlowerEndPoint.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI
import Moya

extension FlowerServerCommunication: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }

    var path: String {
        switch self {
            case .getFlower:
                return "/api/v1/gifts/flowers"
            case .postFlower:
                return "/api/v1/gifts/flowers"
        }
    }

    var method: Moya.Method {
        switch self {
            case .getFlower:
                return .get
            case .postFlower:
                return .post
        }
    }

    var task: Task {
        switch self {
            case .getFlower:
                return .requestPlain
            case .postFlower(let content):
                return .requestJSONEncodable(content)
        }
    }

    var authorizationType: AuthorizationType? {
        switch self {

        default:
            return .bearer
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
