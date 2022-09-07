//
//  PictureService.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.
//
import Foundation
import SwiftUI
import Moya

let moyaService = MoyaProvider<PictureServerCommunication>(plugins: [NetworkLoggerPlugin()])

enum PictureServerCommunication {
    case login(param: LoginRequest)
    case imagePost(comment: String, polaroid: UIImage)
    case imageGet
    case imageListGet
}
