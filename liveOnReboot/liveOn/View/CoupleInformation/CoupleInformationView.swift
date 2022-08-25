//
//  CoupleInformationView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct CoupleInformationView: View {
    @State private var showChangeNickNameAlert = false
    @State private var showChangeOfficialDayAlert = false
    @State private var changeNickNameInput = "재헌"
    @State private var officialDate = Date.now
    var body: some View {
                List {
                    NavigationLink(destination: ChangeNickNameView(nickNameTemp: $changeNickNameInput)){
                        HStack {
                        Text("내 이름")
                                .font(.TextStyles.handWrittenBody)
                        Spacer()
                            Text(changeNickNameInput)
                                .font(.TextStyles.handWrittenCallout)
                                .opacity(0.8)
                        }
                        .padding(.vertical, 12)
                    }
                    .foregroundColor(.textBodyColor)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Text("상대")
                                .font(.TextStyles.handWrittenBody)
                        Spacer()
                            Text("유진")
                                .font(.TextStyles.handWrittenCallout)
                                .opacity(0.8)
                    }
                    .padding(.vertical, 12)
                    .foregroundColor(.textBodyColor)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    NavigationLink(destination: ChangeOfficialDateView(officialDay: $officialDate)){
                        HStack {
                        Text("우리의 1일")
                                .font(.TextStyles.handWrittenBody)
                        Spacer()
                            Text(officialDate.toString(dateFormat: "YYYY년 M월 d일"))
                                .font(.TextStyles.handWrittenCallout)
                                .opacity(0.8)
                        }
                        .padding(.vertical, 12)
                    }
                    .listRowBackground(Color.clear)
                    .foregroundColor(.textBodyColor)
                    .listRowSeparator(.hidden)
                }
        .listRowBackground(Color.clear)
        .navigationTitle("커플정보")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SettingView()) {
                    Image(systemName: "gearshape")
                }
            }
        }
        .listStyle(.plain)
        .background(Color.backgroundGray)
    }
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .red
        UITableViewCell.appearance().backgroundView?.backgroundColor = .blue
        UINavigationBarAppearance().backgroundColor = .clear
    }
}


struct CoupleInformationView_Previews: PreviewProvider {
    static var previews: some View {
        CoupleInformationView()
    }
}
