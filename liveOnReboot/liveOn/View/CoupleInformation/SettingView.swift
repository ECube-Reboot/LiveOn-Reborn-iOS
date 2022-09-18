//
//  CoupleInformationView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List {
            NavigationLink("오픈소스 라이선스", destination: WebView(urlToLoad: "https://italsehf.notion.site/liveOn-ab35202941ea4a5386f1d7e4ec6d7b9c"))
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding(.vertical, 12)
            NavigationLink("이용약관", destination: WebView(urlToLoad: "https://url.kr/w24scn"))
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding(.vertical, 12)
            NavigationLink("회원탈퇴", destination: WithdrawalRequestView())
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding(.vertical, 12)
        }
        .listRowBackground(Color.clear)
        .navigationTitle("환경설정")
        .navigationBarTitleDisplayMode(.inline)
        .navigationToBack(dismiss)
        .listStyle(.plain)
        .background(Color.backgroundGray)
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
