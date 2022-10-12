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
    case revokeMember
    case editNickName(param: EditNickNameRequest)
    case editOfficialDate(param: String)
    case validateCoupleMatching
}

extension MemberConfigEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .fetchMemberProfile, .postMemberProfile:
                return "/api/v1/member"
            case .revokeMember:
                return "/api/v1/member/withdrawl"
            case .editNickName:
                return "/api/v1/member/nickname"
            case .editOfficialDate:
                return "api/v1/member/officialDate"
            case .validateCoupleMatching:
                return "/api/v1/member/couple"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .fetchMemberProfile, .validateCoupleMatching:
                return .get
            case .postMemberProfile:
                return .post
            case .editNickName, .editOfficialDate:
                return .patch
            case .revokeMember:
                return . patch
        }
    }
    
    var task: Task {
        switch self {
            case .fetchMemberProfile, .revokeMember, .validateCoupleMatching :
                return .requestPlain
            case .editNickName(let request):
                return .requestJSONEncodable(request)
            case  .editOfficialDate(let request):
                return .requestJSONEncodable(request)
            case .postMemberProfile(let result):
                return .requestJSONEncodable(result)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Authorization": "Bearer " + GeneralAPI.token]
    }
    
    
}
