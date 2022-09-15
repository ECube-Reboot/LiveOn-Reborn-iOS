//
//  VoiceMailView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct VoiceMailView: View {
    
    @ObservedObject private var voicemailViewmodel: VoicemailViewModel = VoicemailViewModel.voicemailViewModel
    @Environment(\.dismiss) private var dismiss
    @State var isShowPopUp: Bool = false
    @State var showCreateView: Bool = false
    @State var isLoaded: Bool = false
    @State private var showAlert = false
    @State private var voicemailIndex: Int = 0
    
    
    
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
                                ForEach(voicemailViewmodel.voicemailList, id:\.giftVoiceMailId) { vm in
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
                            ForEach(voicemailViewmodel.voicemailList, id:\.giftVoiceMailId) { vm in
                                SingleVoicemailView(voicemail: vm)
                                    .onTapGesture {
                                        voicemailIndex = vm.giftVoiceMailId
                                        voicemailViewmodel.voicemailGet(id: voicemailIndex)
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
                    NavigationLink("",destination: SendVoicemailView(gotoMain: $showCreateView), isActive: $showCreateView)
                }
                .overlay {
                    if isShowPopUp {
                        VoicemailPopUpView()
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
        .navigationToBack(dismiss)
//        .onTapGesture {
//            isShowPopUp.toggle()
//        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    if GiftManager.isExists {
                        showAlert = true
                    } else {
                        showCreateView = true
                    }
                } label: {
                    Image("addButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24, alignment: .center)
                }
            }
        }
        .alert("선물 일일한도 초과", isPresented: $showAlert) {
            Button("확인", role: .cancel) {  }
        } message: {
            Text("선물은 하루에 한번만 보낼 수 있어요😭")
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
