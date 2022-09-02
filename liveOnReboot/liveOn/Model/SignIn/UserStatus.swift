//
//  UserStatus.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/28.
//

import Foundation

enum UserStatus: Int {
    case nonMember = 0
    case appleSignInFinished = 1
    case informationEntered = 2
    case allSettingFinished = 3
}

extension UserStatus {
    static func updateUserStatus(status: UserStatus) {
        UserDefaults.standard.set(status.rawValue, forKey: "userStatus")
    }
    
    static func currentStatus() -> Int? {
        return UserDefaults.standard.integer(forKey: "userStatus")
    }
    
    static func checkStatus(status: UserStatus)-> Bool {
        return currentStatus() == status.rawValue
    }
}
