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
//            LetterListView()
              CreateVoicemailView(isRecording: false, isRecorded: false)
//              GettingStartView()
          }
        }
    }
}
