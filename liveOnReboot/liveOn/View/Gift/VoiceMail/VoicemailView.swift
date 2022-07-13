//
//  VoiceMailView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct VoiceMailView: View {
    
    let voicemailDummy = [
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "30",
                  title: "title",
                  voiceMailIconNum: 0,
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "5",
                  title: "title",
                  voiceMailIconNum: 0,
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "10",
                  title: "title",
                  voiceMailIconNum: 0,
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "10",
                  title: "title",
                  voiceMailIconNum: 0,
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "10",
                  title: "title",
                  voiceMailIconNum: 0,
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "10",
                  title: "title",
                  voiceMailIconNum: 0,
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "10",
                  title: "title",
                  voiceMailIconNum: 0,
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "10",
                  title: "title",
                  voiceMailIconNum: 0,
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "10",
                  title: "title",
                  voiceMailIconNum: 0,
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0)
    ]
    
    var body: some View {
        VStack {
            if voicemailDummy.count > 8 {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(voicemailDummy, id:\.voiceMailId) { vm in
                            SingleVoicemailView(vm: vm)
                        }
                    }
                    .padding(12)
                    .border(.thinMaterial, width: 1)
                    .background(.regularMaterial)
                    .padding(16)
                    .rotationEffect(Angle(degrees: 180))
                }
                .rotationEffect(Angle(degrees: 180))
            } else {
                Spacer()
                VStack {
                    ForEach(voicemailDummy, id:\.voiceMailId) { vm in
                        SingleVoicemailView(vm: vm)
                    }
                }
                .padding(12)
                .border(.thinMaterial, width: 1)
                .background(.regularMaterial)
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("음성메세지")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VoiceMailView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMailView()
    }
}
