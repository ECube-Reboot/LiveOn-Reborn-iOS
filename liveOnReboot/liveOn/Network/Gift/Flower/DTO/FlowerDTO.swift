//
//  FlowerDTO.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct FlowerGetResponse: Codable {
    let giftFlowerName: String
    let comment: String

//    let message: String
//    let senderName: String
//    let sendDate: String
//    let message: String
}

struct FlowerPostRequest: Codable {
    let flowerName: String
    let message: String
}
