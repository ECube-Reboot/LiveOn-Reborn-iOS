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

        case .imagePost(let comment, let polaroid):
            var multipartForm: [MultipartFormData] = []
            multipartForm.append(MultipartFormData(provider: .data(Data(String(comment).utf8)), name: "comment"))
            if let imageDataJPEG = polaroid.jpegData(compressionQuality: 1) {
                multipartForm.append(MultipartFormData(provider: .data(imageDataJPEG), name: "polaroid", fileName: "sampleTest", mimeType: "sample/png"))
            } else if let imageDataPNG = polaroid.pngData(){
                multipartForm.append(MultipartFormData(provider: .data(imageDataPNG), name: "polaroid", fileName: "sampleTest", mimeType: "sample/png"))
            }
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
                    "Authorization": "Bearer "+GeneralAPI.prodtoken]
        default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer "+GeneralAPI.prodtoken]
        }
    }
}
