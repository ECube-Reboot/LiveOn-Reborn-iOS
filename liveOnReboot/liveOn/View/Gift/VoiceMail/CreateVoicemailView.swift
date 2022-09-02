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
    
    @State var isRecording: Bool
    @State var isRecorded: Bool
    
    let date = Date.now
    
    var body: some View {
        GeometryReader { frame in
            VStack {
                Spacer()
                    .frame(height: frame.size.height * 0.05)
                
                TextField("제목을 입력하세요", text: $voicemail.title)
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
                
                if voicemail.isRecording == false && voicemail.isRecorded == false {
                    VStack {
                        Text(voicemail.recordingTimeInString)
                        ZStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.recordingBtnBackground)
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.recordingBtn)
                                .onTapGesture {
                                    voicemail.startRecording()
                                }
                        }
                    }
                } else if voicemail.isRecording == true && voicemail.isRecorded == false {
                    VStack {
                        Text(voicemail.recordingTimeInString)
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
                                    voicemail.recordingTimeInString = "0:00"
                                }
                        }
                    }
                } else {
                    VStack {
                        Text(voicemail.playingTimeInString)
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
                                .padding(.leading, 5)
                                .onTapGesture {
                                    voicemail.startPlaying()
                                }
                        }
                    }
                }
            }
        }
    }
}
