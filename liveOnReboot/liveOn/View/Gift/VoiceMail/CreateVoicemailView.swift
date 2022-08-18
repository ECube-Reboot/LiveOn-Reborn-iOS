//
//  CreateVoicemailView.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/08/18.
//

import SwiftUI

struct CreateVoicemailView: View {
    
    @ObservedObject var voicemail = VoicemailViewModel()
    @FocusState private var isFocused: Bool
    
    let date = Date.now
    
    var body: some View {
        GeometryReader { frame in
            VStack {
                
                Spacer()
                    .frame(height: 80)
                
                TextField("제목을 입력하세요", text: $voicemail.title)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 20)
                    .focused($isFocused)
                Text(date.dateToString(date))
                
                Spacer()
                    .frame(height: 80)
                
                HStack {
                    Spacer()
                    Image("cassette_horizontal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: frame.size.width * 0.9)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 100)
                
                if voicemail.audioRecorder.isRecording == false && voicemail.isRecorded == false {
                    VStack {
                        Text(" ")
                        ZStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.recordingBtnBackground)
                            Image(systemName: "circle.fill")
                                .resizable()
                                .foregroundColor(Color.recordingBtn)
                                .frame(width: 50, height: 50)
                                .onTapGesture {
                                    voicemail.startRecording()
                                }
                        }
                    }
                } else if voicemail.audioRecorder.isRecording == true && voicemail.isRecorded == false {
                    VStack {
                        Text(voicemail.timeInString)
                        ZStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.recordingBtnBackground)
                            Image(systemName: "stop.fill")
                                .resizable()
                                .foregroundColor(Color.recordingBtn)
                                .frame(width: 40, height: 40)
                                .onTapGesture {
                                    voicemail.stopRecording()
                                    voicemail.fetchRecording()
                                    voicemail.timeInString = "0:00"
                                }
                        }
                    }
                } else {
                    Text(" ")
                    ZStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.recordingBtnBackground)
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.recordingBtn)
                            .frame(width: 40)
                            .onTapGesture {
                                if let recordingURL = voicemail.recording?.fileURL {
                                    voicemail.startPlaying(url: recordingURL)
                                } else {
                                    print("재생할 수 없음")
                                }
                            }
                    }
                }
                
            }
        }
    }
}

struct CreateVoicemailView_Previews: PreviewProvider {
    static var previews: some View {
        CreateVoicemailView()
    }
}
