//
//  APIEnvironment.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/16.
//
//MARK: API 관련 전역으로 사용되는 객체를 다루는 파일
import Foundation

struct API {
    static let baseURL = "http://13.124.90.96:8080"
    static let token = "Bearer " + "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdHJpbmciLCJyb2xlIjoiVVNFUiIsImV4cCI6MTY1NzkzOTI2NywiaWF0IjoxNjU1MzQ3MjY3fQ.EOwAlXucfoqx9dzUkcheXJAfLSZrfibSiUxDbJbJbSs"
}
enum AuthAPI {
    case login(request: LoginRequestDTO)
}
