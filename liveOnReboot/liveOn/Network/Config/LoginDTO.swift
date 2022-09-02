//
//  LoginDTO.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.
//
// MARK: DTO(Data Transfer Object)/  로그인 통신을 위해 필요한 양식을 담는 객체
import Foundation

struct LoginResponseDTO: Decodable {
    let accessToken: String
    let isNewMember: Bool
    let refreshToken: String
    let userSettingDone: Bool
}

struct LoginRequestDTO: Encodable {
    let accessToken: String
}

// MARK: Login DTO가 두개던데 추후 로그인 담당자가 선택해서 삭제해야함 
struct LoginRequest: Codable {
    var name: String
}

struct LoginResponse: Codable {
    let accessToken: String
    let isNewMember: Bool
    let refreshToken: String
    let userSettingDone: Bool
}
