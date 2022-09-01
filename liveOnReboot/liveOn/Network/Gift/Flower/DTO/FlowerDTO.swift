//
//  FlowerDTO.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//
import SwiftUI

struct FlowerGetResponse: Codable {
    let giftFlowerId: Int
    let giftFlowerImage: String
}

struct FlowerPostRequest: Codable {
    let flowerId: String
    let message: String
}
