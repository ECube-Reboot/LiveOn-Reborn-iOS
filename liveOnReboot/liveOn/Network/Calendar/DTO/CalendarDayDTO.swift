//
//  CalendarDayDTO.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/09/06.
//

import Foundation

struct CalendarDayResponse: Codable {
    let audioResponseList: [AudioResponseList]
    let eventResponse: [EventResponse]
    let flowerResponseList: [FlowerResponseList]
    let noteResponseList: [NoteResponseList]
    let polaroidResponseList: [PolaroidResponseList]
    
    init() {
    audioResponseList = [AudioResponseList]()
        eventResponse = [EventResponse]()
        flowerResponseList = [FlowerResponseList]()
        noteResponseList = [NoteResponseList]()
        polaroidResponseList = [PolaroidResponseList]()
    }
}

// MARK: - AudioResponseList
struct AudioResponseList: Codable {
    let createdAt: String
    let currentUser: Bool
    let giftVoiceMailDuration, title, userNickName, voiceMail: String
    let voiceMailID: Int

    enum CodingKeys: String, CodingKey {
        case createdAt, currentUser, giftVoiceMailDuration, title, userNickName, voiceMail
        case voiceMailID = "voiceMailId"
    }
}

// MARK: - EventResponse
struct EventResponse: Codable {
    let upcomingEventDate: String
    let upcomingEventID: Int
    let upcomingEventMemo, upcomingEventTitle: String

    enum CodingKeys: String, CodingKey {
        case upcomingEventDate
        case upcomingEventID = "upcomingEventId"
        case upcomingEventMemo, upcomingEventTitle
    }
}

// MARK: - FlowerResponseList
struct FlowerResponseList: Codable {
    let flowerName, message, senderName, sentDate: String
}

// MARK: - NoteResponseList
struct NoteResponseList: Codable {
    let color, content, createdAt: String
    let noteID: Int
    let senderName: String

    enum CodingKeys: String, CodingKey {
        case color, content, createdAt
        case noteID = "noteId"
        case senderName
    }
}

// MARK: - PolaroidResponseList
struct PolaroidResponseList: Codable {
    let comment, createdAt: String
    let giftPolaroidID: Int
    let giftPolaroidImage: String
    let polaroidID: Int
    let userNickName: String

    enum CodingKeys: String, CodingKey {
        case comment, createdAt
        case giftPolaroidID = "giftPolaroidId"
        case giftPolaroidImage
        case polaroidID = "polaroidId"
        case userNickName
    }
}
