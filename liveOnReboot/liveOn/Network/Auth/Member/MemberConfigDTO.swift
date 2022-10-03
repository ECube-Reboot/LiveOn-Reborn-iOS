//
//  MemberConfigDTO.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/09/06.
//

import Foundation

struct FetchMemberProfile: Codable {
    let currentUserName: String
    let officialDate: String
    let partnerName: String
    init() {
        currentUserName = ""
        officialDate = ""
        partnerName = ""
    }
}

struct PostMemberProfile: Codable {
    let birthDay, nickName: String
}

struct EditMemberProfileRequest: Codable {
    let nickName: String
}

struct EditMemberProfileResponse: Codable {
    let currentUserName: String
    let officialDate: String
    let partnerName: String
}

struct EditNickNameRequest: Codable {
    let nickName: String
}

struct IsCoupleMatched: Codable {
    let coupleMatched: Bool
}
