//
//  GiftsMainEndPoint.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/09/13.
//

import Foundation
import Moya

extension GiftsMain: TargetType {

    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .giftExists:
                return "api/v1/gifts/main/gift-exists"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .giftExists:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case .giftExists:
                return .requestPlain
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
                        "Authorization": "Bearer " + GeneralAPI.prodtoken]
        }
    }
}
