//
//  VoicemailPopUpView.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/08/26.
//

import SwiftUI

struct VoicemailPopUpView: View {
    
    @ObservedObject private var voicemailViewmodel: VoicemailViewModel = VoicemailViewModel.voicemailViewModel
    
    @State var isPlaying: Bool = false
    
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
                        
                        Image(systemName: isPlaying ? "pause.fill": "play.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.recordingBtn)
                            .frame(width: isPlaying ? 30 : 40)
                            .onTapGesture {
                                isPlaying.toggle()
                                if isPlaying {
                                    voicemailViewmodel.playGet()
                                } else {
                                    voicemailViewmodel.stopPlaying()
                                }
                                
                            }
                            .padding(.leading, isPlaying ? 0 : 5)
                    }
                }
            }
        }
    }
}

