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
}

extension MemberConfigEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        return "/api/v1/member"
    }
    
    var method: Moya.Method {
        switch self {
            case .fetchMemberProfile:
                return .get
            case .postMemberProfile:
                return .post
            case .editMemberProfile:
                return .patch
        }
    }
    
    var task: Task {
        switch self {
            case .fetchMemberProfile, .postMemberProfile :
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
