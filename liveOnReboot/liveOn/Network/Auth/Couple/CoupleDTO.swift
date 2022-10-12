//
//  CoupleDTO.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/10/03.
//

import Foundation

struct InviteCode: Codable {
    let code: String
}

struct OfficialDate: Codable {
    let officialDate: String
}



struct CoupleProfileResponse: Codable {
    let currentUserName: String
    let officialDate: String
    let partnerName: String
    init() {
        currentUserName = ""
        officialDate = ""
        partnerName = ""
    }
}
