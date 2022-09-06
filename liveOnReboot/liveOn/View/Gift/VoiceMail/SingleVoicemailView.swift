//
//  SingleVoicemailView.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/07/10.
//
import SwiftUI

struct SingleVoicemailView: View {
    
    let voicemail: VoicemailGetResponse
    let voicemailIconNumber = "cassetteIcon0\(Int.random(in: 1..<5))"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .fill(Color("F2F0F0"))
                    .frame(width: 10, height: 60, alignment: .center)
                
                HStack {
                    Image(voicemailIconNumber)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44, alignment: .center)
                    
                    // MARK: 정보부분
                    VStack(alignment: .leading, spacing: 4) {
                        Text(voicemail.title)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        HStack {
                            Text(voicemail.createdAt)
                            Spacer()
                            Text("from. \(voicemail.userNickName)")
                        }
                    }
                    .font(.caption)
                    .opacity(0.9)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
                    .background(Color.cassetteGreen)
                    .foregroundColor(.white)
                    
                    VStack(alignment: .center) {
                        if Int(voicemail.giftVoiceMailDuration)! < 10 {
                        Text("00:0\(voicemail.giftVoiceMailDuration)")
                            .rotationEffect(.degrees(-90.0))
                            .font(.caption)
                            .foregroundColor(.black)
                        } else {
                            Text("00:\(voicemail.giftVoiceMailDuration)")
                                .rotationEffect(.degrees(-90.0))
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                }
                .background(.thinMaterial)
                .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
            }
            Rectangle()
                .fill(Color(uiColor: .systemGray5))
                .frame(width: .infinity, height: 4, alignment: .leading)
        }
        .border(.thinMaterial, width: 3)
        .border(.white, width: 2)
        .border(.thinMaterial, width: 2)
        .overlay(Rectangle().fill(.regularMaterial).opacity(0.2))
    }
}
