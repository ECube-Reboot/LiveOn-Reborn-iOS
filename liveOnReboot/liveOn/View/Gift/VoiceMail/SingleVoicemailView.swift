//
//  SingleVoicemailView.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/07/10.
//

import SwiftUI

struct SingleVoicemailView: View {
    
    let vm: Voicemail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .fill(Color("F2F0F0"))
                    .frame(width: 10, height: 60, alignment: .center)
                
                HStack {
//                    Image(vm.voiceMailIconNum)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 44, height: 44, alignment: .center)
                    
                    // MARK: 정보부분
                    VStack(alignment: .leading, spacing: 4) {
                        Text(vm.title)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        HStack {
                            Text(vm.createdAt)
                            Spacer()
                            Text("from. \(vm.userNickName)")
                        }
                    }
                    .font(.caption)
                    .opacity(0.9)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    
                    VStack(alignment: .center) {
                        if Int(vm.giftVoiceMailDuration)! < 10 {
                        Text("00:0\(vm.giftVoiceMailDuration)")
                            .rotationEffect(.degrees(-90.0))
                            .font(.caption)
                            .foregroundColor(.black)
                        } else {
                            Text("00:\(vm.giftVoiceMailDuration)")
                                .rotationEffect(.degrees(-90.0))
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                }
                .background(.thinMaterial)
                .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
            }
            Rectangle()
                .fill(Color(uiColor: .systemGray5))
                .frame(width: .infinity, height: 4, alignment: .leading)
        }
        .border(.thinMaterial, width: 3)
        .border(.white, width: 2)
        .border(.thinMaterial, width: 2)
        .overlay(Rectangle().fill(.regularMaterial).opacity(0.2))
    }
}

struct SingleVoicemailView_Previews: PreviewProvider {
    static var previews: some View {
        SingleVoicemailView(vm: Voicemail(createdAt: "2022-07-10",
                                          giftVoiceMailDuration: "10",
                                          title: "title",
                                          voiceMailIconNum: 0,
                                          userNickName: "userNickName",
                                          voiceMail: "voiceMail",
                                          voiceMailId: 0))
    }
}
