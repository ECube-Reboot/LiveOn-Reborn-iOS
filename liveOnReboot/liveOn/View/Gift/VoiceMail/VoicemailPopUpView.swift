//
//  VoicemailPopUpView.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/08/26.
//

import SwiftUI

struct VoicemailPopUpView: View {
    
    @State var isPlaying: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 80)
                
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
                        }
                        .padding(.leading, isPlaying ? 0 : 5)
                }
            }
        }
    }
}

