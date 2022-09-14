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
            NavigationLink(destination: WebView(urlToLoad: "https://italsehf.notion.site/liveOn-ab35202941ea4a5386f1d7e4ec6d7b9c")){
                Text("오픈소스 라이선스")
                        .font(.TextStyles.handWrittenBody)
            }
            .foregroundColor(.textBodyColor)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding(.vertical, 12)
            NavigationLink(destination: WebView(urlToLoad: "https://url.kr/w24scn")){
                Text("이용약관")
                        .font(.TextStyles.handWrittenBody)
            }
            .foregroundColor(.textBodyColor)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding(.vertical, 12)
            NavigationLink(destination: WithdrawalRequestView()){
                Text("회원탈퇴")
                        .font(.TextStyles.handWrittenBody)
            }
            .foregroundColor(.textBodyColor)
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
