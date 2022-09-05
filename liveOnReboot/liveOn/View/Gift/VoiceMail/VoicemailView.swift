//
//  VoiceMailView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct VoiceMailView: View {
    
    @ObservedObject private var voicemailViewmodel: VoicemailViewModel = VoicemailViewModel.voicemailViewModel
    
    @State var isShowPopUp: Bool = false
    @State var showCreateView: Bool = false
    @State var isLoaded: Bool = false
    
    var body: some View {
        ZStack {
            if !isLoaded {
                ProgressView()
            } else {
                VStack {
                    if voicemailViewmodel.voicemailList.isEmpty {
                        Text("주고받은 음성메세지가 없어요🥲")
                    } else if voicemailViewmodel.voicemailList.count > 8 {
                        ScrollView(showsIndicators: false) {
                            VStack {
                                ForEach(voicemailViewmodel.voicemailList, id:\.voiceMailId) { vm in
                                    SingleVoicemailView(voicemail: vm)
                                        .onTapGesture {
                                            withAnimation(.easeOut) {
                                                isShowPopUp.toggle()
                                            }
                                        }
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
                            ForEach(voicemailViewmodel.voicemailList, id:\.voiceMailId) { vm in
                                SingleVoicemailView(voicemail: vm)
                                    .onTapGesture {
                                        withAnimation(.easeOut) {
                                            isShowPopUp.toggle()
                                        }
                                    }
                            }
                        }
                        .padding(12)
                        .border(.thinMaterial, width: 1)
                        .background(.regularMaterial)
                        .padding(16)
                    }
                }
                .overlay {
                    if isShowPopUp {
                        VoicemailPopUpView(isPlaying: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .background(.ultraThinMaterial)
                            .onTapGesture {
                                withAnimation {
                                    isShowPopUp.toggle()
                                }
                            }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("음성메세지")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            isShowPopUp.toggle()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SendVoicemailView(gotoMain: $showCreateView), isActive: $showCreateView) {
                    Image("addButton")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .task {
            await voicemailViewmodel.voicemailListGet {
                isLoaded = true
            }
        }
    }
}


extension Voicemail {
    
#if DEBUG
    static func dummyData() -> [Voicemail] {
        return [
            Voicemail(createdAt: "2022-07-10",
                      giftVoiceMailDuration: "30",
                      title: "title",
                      voiceMailIconName: "cassetteIcon01",
                      userNickName: "userNickName",
                      voiceMail: "voiceMail",
                      voiceMailId: 0),
            Voicemail(createdAt: "2022-07-10",
                      giftVoiceMailDuration: "5",
                      title: "title",
                      voiceMailIconName: "cassetteIcon01",
                      userNickName: "userNickName",
                      voiceMail: "voiceMail",
                      voiceMailId: 0),
            Voicemail(createdAt: "2022-07-10",
                      giftVoiceMailDuration: "10",
                      title: "title",
                      voiceMailIconName: "cassetteIcon01",
                      userNickName: "userNickName",
                      voiceMail: "voiceMail",
                      voiceMailId: 0),
            Voicemail(createdAt: "2022-07-10",
                      giftVoiceMailDuration: "10",
                      title: "title",
                      voiceMailIconName: "cassetteIcon01",
                      userNickName: "userNickName",
                      voiceMail: "voiceMail",
                      voiceMailId: 0),
            Voicemail(createdAt: "2022-07-10",
                      giftVoiceMailDuration: "10",
                      title: "title",
                      voiceMailIconName: "cassetteIcon01",
                      userNickName: "userNickName",
                      voiceMail: "voiceMail",
                      voiceMailId: 0),
//            Voicemail(createdAt: "2022-07-10",
//                      giftVoiceMailDuration: "10",
//                      title: "title",
//                      voiceMailIconName: "cassetteIcon01",
//                      userNickName: "userNickName",
//                      voiceMail: "voiceMail",
//                      voiceMailId: 0),
//            Voicemail(createdAt: "2022-07-10",
//                      giftVoiceMailDuration: "10",
//                      title: "title",
//                      voiceMailIconName: "cassetteIcon01",
//                      userNickName: "userNickName",
//                      voiceMail: "voiceMail",
//                      voiceMailId: 0),
//            Voicemail(createdAt: "2022-07-10",
//                      giftVoiceMailDuration: "10",
//                      title: "title",
//                      voiceMailIconName: "cassetteIcon01",
//                      userNickName: "userNickName",
//                      voiceMail: "voiceMail",
//                      voiceMailId: 0),
//            Voicemail(createdAt: "2022-07-10",
//                      giftVoiceMailDuration: "10",
//                      title: "title",
//                      voiceMailIconName: "cassetteIcon01",
//                      userNickName: "userNickName",
//                      voiceMail: "voiceMail",
//                      voiceMailId: 0)
        ]
    }
#endif
}
