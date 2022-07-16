//
//  PictureEndPoint.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.

import Foundation
import Moya

struct PicturePostResponse: Codable {
    let contentRecieved: String
    let imageName: String
}

struct ImageGetResponse: Codable {
    let createdAt: String
    var giftPolaroidId: Int64
    let giftPolaroidImage: String
    let userNickName: String
}

// MARK: Test용 임시 데이터
var testImageData: PicturePostResponse?
var loadedImage: ImageGetResponse?
