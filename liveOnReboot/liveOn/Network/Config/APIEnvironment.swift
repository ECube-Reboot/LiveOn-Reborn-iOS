//
//  APIEnvironment.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.
//
//MARK: API 관련 전역으로 사용되는 객체를 다루는 파일
import Foundation

struct GeneralAPI {
    static let baseURL = "https://prod.liveon-api.shop"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiLsnqztl4wiLCJyb2xlIjoiVVNFUiIsImV4cCI6MTY2NDQzODA1MCwiaWF0IjoxNjYxODQ2MDUwfQ.SDIg3XmZsNjiqOohjrP98hjvJ1eMYORgKTcVwizB7NA"
    static var prodtoken = KeyChain.read(key: "accessToken") ?? ""
}

enum AuthAPI {
    case login(request: LoginRequestDTO)
}
