//
//  MemberView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/10/07.
//

import SwiftUI

struct MemberView: View {
    var body: some View {
        VStack {
        List {
            NavigationLink(destination: WebView(urlToLoad: "https://github.com/ECube-Reboot/LiveOn-Reborn-iOS")) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Ecube")
                        .font(.TextStyles.largeCalendarNumber)
                        .foregroundColor(Color.textBodyColor)
                    Text("팀 이큐브")
                        .opacity(0.6)
                        .offset(y: -5)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
            .listSectionSeparator(.hidden)
  
            MemberCell(memberImage: "cassetteIcon02", memberName: "Min", memberRole: "Keum Minseok", gitUrl: "https://github.com/italsehf")
            MemberCell(memberImage: "cassetteIcon03", memberName: "Id", memberRole: "Lee Seongmin", gitUrl: "https://www.github.com/seongmin221")
            MemberCell(memberImage: "cassetteIcon01", memberName: "Milli", memberRole: "Lee jinhee", gitUrl: "https://github.com/jinccc97")
            MemberCell(memberImage: "cassetteIcon04", memberName: "Teemo", memberRole: "Kim Boyoung", gitUrl: "https://www.github.com/teethemoji")
            MemberCell(memberImage: "cassetteIcon02", memberName: "Daon", memberRole: "Hong Jihye", gitUrl: "https://github.com/jola7373")
            MemberCell(memberImage: "cassetteIcon03", memberName: "Rookie", memberRole: "Jang Jisoo", gitUrl: "https://github.com/Rookie0031")
        }
        }
        .listStyle(.plain)
        .background(Color.backgroundGray)
        .navigationTitle("만든 사람들")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension MemberView {
    struct MemberCell: View {
        let memberImage: String
        let memberName: String
        let memberRole: String
        let gitUrl: String
        var body: some View {
            NavigationLink(destination: WebView(urlToLoad: gitUrl)) {
                HStack {
                    Image(memberImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.1)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(memberName)
                        Text(memberRole)
                            .font(.caption)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                    }
                    Spacer()
                    Text("git")
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
                .padding(.vertical)
            }
            .listRowBackground(Color.clear)
        }
    }
}
struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MemberView()
        }
    }
}
