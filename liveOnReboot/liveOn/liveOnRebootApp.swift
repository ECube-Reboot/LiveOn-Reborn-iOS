//
//  liveOnRebootApp.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/06.
//

import SwiftUI

@main
struct liveOnRebootApp: App {
    
    //테스트용 임시
    @State var tempGotoMain = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FlowerListView()
                    .environmentObject(FlowerViewModel())
                switch UserStatus.currentStatus() {
                case 0:
                    //                          .nonMember:
                    GettingStartView()
                case 1:
                    //                          .appleSignInFinished:
                    InputNickNameView()
                case 2:
                    //                          .informationEntered:
                    InviteCodeView(userData: SignInUser())
                case 3:
                    //                          .allSettingFinished:
                    GiftBoxView()
                default :
                    GettingStartView()
                }
            }
        }
    }
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
}
