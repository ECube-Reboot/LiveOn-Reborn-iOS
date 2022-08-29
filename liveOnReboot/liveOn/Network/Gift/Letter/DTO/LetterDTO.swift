//
//  LetterDTO.swift
//  liveOnReboot
//
//  Created by Keum Jineeee on 2022/07/09.
//

import SwiftUI

struct LetterPostRequest: Codable {
    let color: String
    let content: String
}

struct LettersGetResponse: Codable {
    let letters: [LetterGet]
}

struct LetterGet: Codable {
    let color: String
    let content: String
    let createdAt: String
    let giftNoteId: Int64
    let userNickName: String
}
