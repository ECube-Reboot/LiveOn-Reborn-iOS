//
//  APIEnvironment.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.
//
//MARK: API 관련 전역으로 사용되는 객체를 다루는 파일
import Foundation

struct GeneralAPI {
    static let baseURL = "http://13.124.90.96:8080"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiLshLHrr7wiLCJyb2xlIjoiVVNFUiIsImV4cCI6MTY2NTgzOTM0MSwiaWF0IjoxNjYzMjQ3MzQxfQ._b9maMThJfxglCrjQcjnmdak6364X7QYFRWPmsH0m84"
    static var prodtoken = KeyChain.read(key: "accessToken") ?? ""
}

enum AuthAPI {
    case login(request: LoginRequestDTO)
}
