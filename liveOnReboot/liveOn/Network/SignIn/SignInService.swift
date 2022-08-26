//
//  SignInService.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/23.
//

import Foundation
import Moya

let signInMoyaService = MoyaProvider<SignInService>(plugins: [NetworkLoggerPlugin()])

enum SignInService {
    case getCode
    case checkCode(param: String)
}
