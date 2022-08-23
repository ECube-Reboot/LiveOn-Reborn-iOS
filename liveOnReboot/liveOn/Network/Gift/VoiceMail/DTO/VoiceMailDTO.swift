//
//  VoiceMailDTO.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import Foundation

struct VoicemailListGetResponse: Codable {
    let createdAt: String
    let currentUser: Bool
    let giftVoiceMailDuration: String
    let giftVoiceMailId: Int
    let title: String
    let userNickName: String
}

struct VoicemailGetResponse: Codable {
    
}

struct VoicemailPostResponse: Codable {
    
}
