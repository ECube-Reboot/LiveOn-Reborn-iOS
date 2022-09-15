//
//  VoicemailPopUpView.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/08/26.
//

import SwiftUI

struct VoicemailPopUpView: View {
    
    @ObservedObject private var voicemailViewModel: VoicemailViewModel = VoicemailViewModel.voicemailViewModel
    
    var body: some View {
        GeometryReader { frame in
            ZStack {
                VStack {
                    Spacer()
                        .frame(height: frame.size.height * 0.1)
                    
                    if let title = voicemailViewModel.singleVoicemail?.title, let createdAt = voicemailViewModel.singleVoicemail?.createdAt {
                        Text(title)
                            .frame(width: 300, height: 20)
                        Text(reformatDate(from: createdAt))
                    }
                    
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
                        
                        Image(systemName: voicemailViewModel.isPlaying ? "pause.fill": "play.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.recordingBtn)
                            .frame(width: voicemailViewModel.isPlaying ? 30 : 40)
                            .onTapGesture {
                                voicemailViewModel.isPlaying.toggle()
                                playWhenTap()
                            }
                            .padding(.leading, voicemailViewModel.isPlaying ? 0 : 5)
                    }
                }
            }
        }
    }
}

extension VoicemailPopUpView {
    private func playWhenTap() {
        if voicemailViewModel.isPlaying {
            voicemailViewModel.downloadVoicemail()
        } else {
            voicemailViewModel.stopPlaying()
        }
    }
    
    private func reformatDate(from str: String) -> String {
        let positions = [2, 3, 5, 6, 8, 9]
        var newString: String = ""
        for index in positions {
            newString += String(str[str.index(str.startIndex, offsetBy: index)])
        }
        return newString
    }
}
