//
//  VoiceMailDTO.swift
//  liveOnReboot
//
//  Created by Seongmin Lee on 2022/07/09.
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
    let createdAt: String
    let currentUser: Bool
    let giftVoiceMailDuration: String
    let title: String
    let userNickName: String
    let voiceMail: String
    let voiceMailId: Int
}
