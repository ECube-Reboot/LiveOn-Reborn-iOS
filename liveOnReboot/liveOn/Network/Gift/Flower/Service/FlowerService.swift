//
//  FlowerService.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//
import SwiftUI
import Moya

let flowerMoyaService = MoyaProvider<FlowerServerCommunication>(plugins: [NetworkLoggerPlugin()])

enum FlowerServerCommunication {
    case getFlower
    case postFlower(content: FlowerPostRequest)
}
