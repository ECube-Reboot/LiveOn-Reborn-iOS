//
//  AppleSocialLogin.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/16.
//

import SwiftUI
import AuthenticationServices
import Foundation

struct AppleUser: Codable {
    let userId: String
    let identityToken: String
    
    init?(credentials: ASAuthorizationAppleIDCredential) {
        guard
//            let firstName = credentials.fullName?.givenName,
//            let lastName = credentials.fullName?.familyName,
//            let email = credentials.email,
            let idToken = credentials.identityToken,
            let idTokenString = String(data: idToken, encoding: .utf8)
        else {return nil}
        
        self.userId = credentials.user
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
        self.identityToken = idTokenString
        
    }
}
