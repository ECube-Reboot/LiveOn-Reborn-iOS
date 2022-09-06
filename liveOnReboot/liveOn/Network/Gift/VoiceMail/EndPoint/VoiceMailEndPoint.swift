//
//  VoiceMailEndPoint.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import Foundation
import SwiftUI
import Moya

extension VoicemailServerCommunication: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/api/v1/test/login"
        case .voicemailPost:
            return "/api/v1/gifts/voicemail"
        case .voicemailListGet:
            return "/api/v1/gifts/voicemail"
        case .voicemailGet(let id):
            return "/api/v1/gifts/voicemail/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .voicemailPost:
            return .post
        case .voicemailListGet, .voicemailGet:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestJSONEncodable(param)
            
        case .voicemailPost(let title, let voicemail, let voicemailDuration):
            var multipartForm: [MultipartFormData] = []
            
            multipartForm.append(MultipartFormData(provider: .data(Data(String(title).utf8)), name: "title", fileName: "title"))
            if let recordingData: Data = try? Data(contentsOf: voicemail.fileURL) {
                multipartForm.append(MultipartFormData(provider: .data(recordingData), name: "voiceMail", fileName: "\(title).m4a", mimeType: "audio/m4a"))
            }
            multipartForm.append(MultipartFormData(provider: .data(Data(String(voicemailDuration).utf8)), name: "voiceMailDuration", fileName: "voiceMailDuration"))
            print("")
            print("multipartForm----------: \(multipartForm)")
            print("")
            return .uploadMultipart(multipartForm)
            
        case .voicemailListGet, .voicemailGet:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .voicemailPost:
            return ["Content-Type": "multipart/form",
                    "Authorization": "Bearer "+GeneralAPI.token]
        default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer "+GeneralAPI.token]
        }
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .login, .voicemailPost:
            return nil
        default:
            return .bearer
        }
    }
}
