//
//  FlowerDTO.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct FlowerGetResponse: Codable {
    let flowerType: String
    let message: String
}

struct FlowerPostRequest: Codable {
    let flowerType: String
    let message: String
}
