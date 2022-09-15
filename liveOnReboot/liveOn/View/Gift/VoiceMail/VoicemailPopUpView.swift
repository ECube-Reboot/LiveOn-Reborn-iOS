//
//  VoicemailPopUpView.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/08/26.
//

import SwiftUI

struct VoicemailPopUpView: View {
    
    @ObservedObject private var voicemailViewmodel: VoicemailViewModel = VoicemailViewModel.voicemailViewModel
    
//    @Binding var voicemailIndex: Int
    
//    @Binding var singleVoicemail: VoicemailGetResponse?
    
    var body: some View {
        GeometryReader { frame in
            ZStack {
                VStack {
                    Spacer()
                        .frame(height: frame.size.height * 0.1)
                    
//                    Text(singleVoicemail!.title)
//                        .frame(width: 300, height: 20)
//                    Text(singleVoicemail!.createdAt)
                    
                    Spacer()
                        .frame(height: frame.size.height * 0.1)
                    
                    Image("cassette_horizontal")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                        .padding()
                    
                    Spacer()
                        .frame(height: 100)
                    
                    ZStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.shadowColor)
                            .blendMode(.multiply)
                        
                        Image(systemName: voicemailViewmodel.isPlaying ? "pause.fill": "play.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.recordingBtn)
                            .frame(width: voicemailViewmodel.isPlaying ? 30 : 40)
                            .onTapGesture {
                                voicemailViewmodel.isPlaying.toggle()
                                playWhenTap()
                            }
                            .padding(.leading, voicemailViewmodel.isPlaying ? 0 : 5)
                    }
                }
            }
        }
    }
}

extension VoicemailPopUpView {
    private func playWhenTap() {
        if voicemailViewmodel.isPlaying {
            voicemailViewmodel.downloadVoicemail()
        } else {
            voicemailViewmodel.stopPlaying()
        }
    }
}
