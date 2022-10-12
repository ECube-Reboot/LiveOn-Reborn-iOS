//
//  LetterEndPoint.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI
import Moya

extension LetterServerCommunication: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .getNotes:
                return "/api/v1/gifts/notes"
            case .postNote:
                return "/api/v1/gifts/notes"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getNotes:
                return .get
            case .postNote:
                return .post
        }
    }
    
    var task: Task {
        switch self {
            case .getNotes:
                return .requestPlain
            case .postNote(let content):
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
