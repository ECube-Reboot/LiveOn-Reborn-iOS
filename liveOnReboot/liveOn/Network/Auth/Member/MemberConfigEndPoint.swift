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
    case editMemberProfile(param: EditMemberProfileRequest)
    case revokeMember
}

extension MemberConfigEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .fetchMemberProfile, .editMemberProfile, .postMemberProfile:
                return "/api/v1/member"
            case .revokeMember:
                return "/api/v1/member/withdrawl"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .fetchMemberProfile:
                return .get
            case .postMemberProfile:
                return .post
            case .editMemberProfile:
                return .patch
            case .revokeMember:
                return . patch
        }
    }
    
    var task: Task {
        switch self {
            case .fetchMemberProfile, .postMemberProfile, .revokeMember :
                return .requestPlain
            case .editMemberProfile(let request):
                return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Authorization": "Bearer " + GeneralAPI.token]
    }
    
    
}
