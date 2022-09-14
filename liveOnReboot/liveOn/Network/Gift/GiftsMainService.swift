//
//  GiftsMainService.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/09/13.
//

import Foundation
import Moya
import SwiftUI

let giftsService = MoyaProvider<GiftsMain>(plugins: [NetworkLoggerPlugin()])

enum GiftsMain {
    case giftExists
}

class GiftManager: ObservableObject {
    @ObservedObject static var singleton: GiftManager = GiftManager()
    static var isExists = false
    
    func isGiftExists() {
        giftsService.request(.giftExists) { response in
            switch response {
                case .success(let result):
                    do {
                        let reply = try result.map(GiftExists.self)
                        GiftManager.isExists = reply.userGifted
                        print(GiftManager.isExists)
                    } catch let err {
                        print(err.localizedDescription)
                        break
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
}

