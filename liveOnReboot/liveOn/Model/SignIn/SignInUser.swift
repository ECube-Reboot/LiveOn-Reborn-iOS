//
//  SignInUserData.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import Foundation

class SignInUser: ObservableObject {
    var nickName: String
    var birthDay: Date
    var officialDay: Date
    
    init() {
        self.nickName = ""
        self.birthDay = Date()
        self.officialDay = Date()
    }
}
