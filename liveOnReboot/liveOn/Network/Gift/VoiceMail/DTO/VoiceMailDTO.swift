//
//  VoiceMailDTO.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import Foundation

// TODO: 이게 필요할지 필요 없을지 아직 모르겠어서 일단 남겨둠요
struct VoicemailListGetResponse: Codable {
    let createdAt: String
    let currentUser: Bool
    let giftVoiceMailDuration: String
    let giftVoiceMailId: Int
    let title: String
    let userNickName: String
}


struct VoicemailGetResponse: Codable {
    let createdAt: String
    let currentUser: Bool
    let giftVoiceMailDuration: String
    let title: String
    let userNickName: String
//    let voiceMail: String
    let giftVoiceMailId: Int
}

struct VoicemailPostResponse: Codable {
    
}
