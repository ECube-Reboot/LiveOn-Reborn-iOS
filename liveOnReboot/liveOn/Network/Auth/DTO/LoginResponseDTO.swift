//
//  LoginResponseDTO.swift
//  liveOnReboot
//
//  Created by Jihye Hong on 2022/08/26.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let accessToken: String
    let isNewMember: Bool
    let refreshToken: String
    let userSettingDone: Bool
}
