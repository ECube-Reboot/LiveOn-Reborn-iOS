//
//  liveOnRebootApp.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/06.
//

import SwiftUI

@main
struct liveOnRebootApp: App {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            if networkManager.isConnected {
                NavigationView {
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
            } else {
                Text("네트워크에 연결되지 않았어요 ㅠ")
                    .foregroundColor(.textBodyColor)
                    .opacity(0.6)
                Button("재연결"){
                    networkManager.startMonitoring()
                }
            }
        }
    }
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
}
