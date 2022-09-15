//
//  SendVoiceMailView.swift
//  liveOnReboot
//
//  Created by Lee Seongmin on 2022/08/30.
//

import SwiftUI

struct SendVoicemailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var voicemail = VoicemailViewModel.voicemailViewModel
    @FocusState private var isFocused: Bool
    
    @State var title: String = ""
    @State var isRecording: Bool = false
    @State var isRecorded: Bool = false
    @State var isPlaying: Bool = false
    @State var showAlertForSend: Bool = false
    @State var showLoading: Bool = false
    @State private var isSent: Bool = false
    
    @Binding var gotoMain: Bool
    
    let date = Date.now
    
    var body: some View {
        GeometryReader { frame in
            VStack {
                Spacer()
                    .frame(height: frame.size.height * 0.1)
                
                TextField("제목을 입력하세요", text: $title)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 20)
                    .focused($isFocused)
                Text(date.dateToString(date))
                
                Spacer()
                    .frame(height: frame.size.height * 0.1)
                
                HStack {
                    Spacer()
                    Image("cassette_horizontal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: frame.size.width * 0.9)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: frame.size.height * 0.1)
                
                
                VStack {
                    if isRecording == false && isRecording == false {
                        Text("0:00")
                    } else if isRecorded == false && isRecording == true {
                        Text(voicemail.recordingTimeInString)
                    } else {
                        Text(voicemail.playingTimeInString)
                    }
                    
                    ZStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.recordingBtnBackground)
                        if isRecording == false && isRecorded == false {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.recordingBtn)
                                .onTapGesture {
                                    isRecording = true
                                    voicemail.startRecording()
                                }
                        } else if isRecording == true && isRecorded == false {
                            Image(systemName: "stop.fill")
                                .resizable()
                                .foregroundColor(Color.recordingBtn)
                                .frame(width: 40, height: 40)
                                .onTapGesture {
                                    isRecording = false
                                    isRecorded = true
                                    voicemail.stopRecording()
                                    voicemail.recordingTimeInString = "0:00"
                                }
                        } else {
                            ZStack {
                                Image(systemName: voicemail.isPlaying ? "pause.fill": "play.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.recordingBtn)
                                    .frame(width: voicemail.isPlaying ? 30 : 40)
                                    .padding(.leading, voicemail.isPlaying ? 0 : 5)
                                    .onTapGesture {
                                        if voicemail.isPlaying {
                                            voicemail.stopPlaying()
                                            voicemail.isPlaying = false
                                        } else {
                                            voicemail.startPlaying()
                                            voicemail.isPlaying = true
                                        }
                                    }
                                HStack {
                                    Spacer()
                                        .frame(width: frame.size.width * 0.3)
                                    Image(systemName: "gobackward")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .onTapGesture {
                                            if voicemail.recording != nil {
                                                voicemail.deleteRecording()
                                                isRecorded = false
                                            }
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if isAbleToSend() {
                            showAlertForSend.toggle()
                        }
                        voicemail.title = title
                    } label: {
                        Text("선물하기")
                    }
                    .disabled(!isAbleToSend())
                    .alert(isPresented: $showAlertForSend) {
                        Alert(title: Text("선물하기"), message: Text("선물은 하루에 하나만 보낼 수 있어요. 쪽지를 보낼까요?"), primaryButton: .cancel(Text("취소")), secondaryButton: Alert.Button.default(Text("보내기")) {
                            showLoading = true
                            voicemail.voicemailPost() {
                                showLoading = false
                                gotoMain = true
                                isSent = true
                                isRecorded = false
                                isRecording = false
                            }
                        })
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("음성메시지")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }
            .overlay {
                if showLoading {
                    LoadingView()
                }
            }
            NavigationLink("", destination: GiftDeliveryView(gotoMain: $gotoMain), isActive: $isSent)
        }
    }
}

extension SendVoicemailView {
    private func isAbleToSend() -> Bool {
        if isRecorded && title != "" {
            return true
        } else {
            return false
        }
    }
}
