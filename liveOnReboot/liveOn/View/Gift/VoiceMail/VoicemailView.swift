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
                  giftVoiceMailDuration: "string",
                  title: "title",
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "string",
                  title: "title",
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0),
        Voicemail(createdAt: "2022-07-10",
                  giftVoiceMailDuration: "string",
                  title: "title",
                  userNickName: "userNickName",
                  voiceMail: "voiceMail",
                  voiceMailId: 0)
    ]
    
    var body: some View {
        VStack {
            if voicemailDummy.count > 8 {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer()
                        
                        
                    }
                }
            }
        }
    }
}

struct VoiceMailView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceMailView()
    }
}
