//
//  MemberConfigEndPoint.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/09/06.
//

import Foundation
import Moya

enum MemberConfigEndPoint {
    case fetchMemberProfile
    case postMemberProfile(param: PostMemberProfile)
    case editNickName(param: EditNickNameRequest)
    case editOfficialDate(param: String)
}

extension MemberConfigEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .editNickName:
                return "/api/v1/member/nickname"
            case .editOfficialDate:
                return "api/v1/member/officialDate"
            default :
                return "/api/v1/member"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .fetchMemberProfile:
                return .get
            case .postMemberProfile:
                return .post
            case .editNickName, .editOfficialDate:
                return .patch
        }
    }
    
    var task: Task {
        switch self {
            case .fetchMemberProfile, .postMemberProfile :
                return .requestPlain
            case .editNickName(let request):
                return .requestJSONEncodable(request)
            case  .editOfficialDate(let request):
                return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Authorization": "Bearer " + GeneralAPI.token]
    }
    
    
}
