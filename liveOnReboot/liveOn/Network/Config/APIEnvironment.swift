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
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiLsnqztl4wiLCJyb2xlIjoiVVNFUiIsImV4cCI6MTY2NDQzODA1MCwiaWF0IjoxNjYxODQ2MDUwfQ.SDIg3XmZsNjiqOohjrP98hjvJ1eMYORgKTcVwizB7NA"
    static var prodtoken = KeyChain.read(key: "accessToken") ?? ""
}

enum AuthAPI {
    case login(request: LoginRequestDTO)
}

struct GeneralAPI {
    static let baseURL = "http://13.124.90.96:8080"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdHJpbmciLCJyb2xlIjoiVVNFUiIsImV4cCI6MTY2MTMyMjg4NCwiaWF0IjoxNjU4NzMwODg0fQ.10quBoJQVn5Ct0qO1yWU6bKDoAGL5hrTShOsEdWQ0fw"
}
