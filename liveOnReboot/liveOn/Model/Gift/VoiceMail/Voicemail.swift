//
//  Voicemail.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/07/10.
//

import Foundation

struct Voicemail: Codable {
    
    let createdAt: String
    let giftVoiceMailDuration: String
    let title: String
    let voiceMailIconName: String
    let userNickName: String
    let voiceMail: String
    let voiceMailId: Int

//    init(getResopnse: VoicemailGetResponse) {
//        createdAt = getResopnse.createdAt
//        giftVoiceMailDuration = getResopnse.giftVoiceMailDuration
//        title = getResopnse.title
//        voiceMailIconName = "cassetteIcon0\(Int.random(in: 1..<5))"
//        userNickName = getResopnse.userNickName
//        voiceMail = getResopnse.voiceMail
//        voiceMailId = getResopnse.voiceMailId
//    }
}
