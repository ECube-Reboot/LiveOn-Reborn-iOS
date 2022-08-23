//
//  PictureEndPoint.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.

import Foundation
import Moya

struct PicturePostResponse: Codable {
    let comment: String
    let polaroid: String
}

struct PictureGetResponse: Codable {
    let createdAt: String
    let giftPolaroidId: Int64
    let giftPolaroidImage: String
    let userNickName: String
//    let comment: String
}
