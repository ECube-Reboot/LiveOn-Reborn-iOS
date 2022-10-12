//
//  CoupleEndpoint.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/10/03.
//

import Foundation
import Moya

enum CoupleEndpoint {
    case getCode
    case checkCode(param: String)
    case postOfficialdate(officialDate: OfficialDate)
    case patchOfficialdate(officialDate: OfficialDate)
    case patchBirthdayDate(birthDay: BirthDay)
}

extension CoupleEndpoint: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .getCode, .checkCode:
                return "/api/v1/couple/code"
            case .patchOfficialdate, .postOfficialdate:
                return "/api/v1/couple/officialdate"
            case .patchBirthdayDate:
                return "/api/v1/member/birthday"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .checkCode, .postOfficialdate:
                return .post
            case .getCode:
                return .get
            case .patchOfficialdate, .patchBirthdayDate:
                return .patch
        }
    }
    
    var task: Task {
        switch self {
            case .getCode:
                return .requestPlain
            case .checkCode(let code):
                return .requestJSONEncodable(code)
            case .postOfficialdate(let date):
                return .requestJSONEncodable(date)
            case .patchOfficialdate(let date):
                return .requestJSONEncodable(date)
            case .patchBirthdayDate(let date):
                return .requestJSONEncodable(date)
        }
        
    }
    
    var headers: [String: String]? {
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer " + GeneralAPI.token]
    }
}
