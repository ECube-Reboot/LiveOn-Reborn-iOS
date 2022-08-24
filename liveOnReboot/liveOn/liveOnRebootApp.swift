//
//  liveOnRebootApp.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/06.
//

import SwiftUI

@main
struct liveOnRebootApp: App {

  @State var tempGotoMain = false
    var body: some Scene {
        WindowGroup {
            NavigationView{
                CalendarView().environmentObject(EventStore())
                    .navigationBarHidden(true)
            }
        }
    }
}
