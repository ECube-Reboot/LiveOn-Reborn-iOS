//
//  CalendarMainEndPoint.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI
import Moya

extension CalendarMainServerCommunication: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
            case .getCalendarMain:
                return "/api/v1/calendar"
            case .postCalendarMain:
                return "/api/v1/calendar"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getCalendarMain:
                return .get
            case .postCalendarMain:
                return .post
        }
    }
    
    var task: Task {
        switch self {
            case .getCalendarMain(let month):
                return .requestParameters(parameters: ["calendarRequest" : month], encoding: URLEncoding.queryString)
            case .postCalendarMain(let content):
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
            case .getCalendarMain:
                return ["Authorization": "Bearer " + GeneralAPI.token]
            default:
                return ["Content-Type": "application/json",
                        "Authorization": "Bearer " + GeneralAPI.token]
        }
    }
}
