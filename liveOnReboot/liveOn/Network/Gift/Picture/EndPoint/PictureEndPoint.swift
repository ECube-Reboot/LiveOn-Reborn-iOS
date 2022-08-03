//
//  PictureEndPoint.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.
import Foundation
import SwiftUI
import Moya

extension PictureServerCommunication: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    var path: String {
        switch self {
        case.login:
            return "/api/v1/test/login"
            
        case .imagePost:
            return "api/v1/gifts/polaroids"
            
            //MARK: Test용 이미지 GET. 추후 수정하거나 삭제 예정
        case .imageGet:
            return "/api/v1/gifts/polaroids/1"
            
        case .imageListGet:
            return "/api/v1/gifts/polaroids"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .imagePost:
            return .post
            
        case .imageGet, .imageListGet:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestJSONEncodable(param)
            
        // MARK: MultiPart HTTP Request format 작성 -> 추후 상세사항 수정예정
        case .imagePost(let comment, let polaroid):
            var multipartForm: [MultipartFormData] = []
            let imageData = polaroid.pngData()
            multipartForm.append(MultipartFormData(provider: .data(Data(String(comment).utf8)), name: "comment"))
            multipartForm.append(MultipartFormData(provider: .data(imageData!), name: "polaroid", fileName: "sample.png", mimeType: "sample/png"))
            return .uploadMultipart(multipartForm)
            
        case .imageGet, .imageListGet:
            return .requestPlain
        }
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .login, .imagePost:
            return nil
            
        default:
            return .bearer
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .imagePost:
            return ["Content-Type": "multipart/form",
                    "Authorization": "Bearer "+GeneralAPI.token]
        default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer "+GeneralAPI.token]
        }
    }
}
