//
//  GiftBoxView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct GiftBoxView: View {
    var body: some View {
        
        VStack (alignment: .leading, spacing: 12) {
            HStack {
                CoupleInfoLabel()
                Spacer()
                NavigationLink(destination: GiftListView()) {
                    Image("addButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36, alignment: .center)
                }
            }
            CalendarLinkView()
            
            VStack {
                LetterAndPictureLinkView()
                VoiceAndFlowerLinkView()
            } // VStack
            .padding(.horizontal)
            
        } // VStack
        .padding(.horizontal)

    } // body
}

struct CoupleInfoLabel: View {
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .padding(8)
            // TODO: 파란색 테두리 색상 변경
                .foregroundColor(Color.teal)
                .frame(width: 194, height: 54, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(.thinMaterial)
                    .shadow(color: Color(red: 239, green: 238, blue: 35), radius: 4, x: 0, y: 4))
            
            HStack {
                
                // TODO: "재헌" -> 상대방의 이름이 들어가게 바꿀 것
                Text("재헌")
                Image("heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 22, alignment: .center)
                // TODO: "유진" -> 유저의 이름이 들어가게 바꿀 것
                Text("유진")
                // TODO: "365" -> 설정된 첫 날 부터 앱이 실행되고 있는 시점까지의 날짜 계산해서 넣기
                Text("D+365")
                
            } // HStack
        } // ZStack
    } // body
}

struct CalendarLinkView: View {
    var body: some View {
        
        NavigationLink(destination: CalendarView()) {
            
            ZStack {
                Image("calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    
                    // TODO: 앱이 실행되는 시점의 달을 영어로 표시
                    Text("July")
                        .foregroundColor(.textBodyColor)
                    
                    // TODO: 앱이 실행되는 시점의 달을 숫자로 표시
                    Text("07")
                        .foregroundColor(.textBodyColor)
                    
                }
            } // ZStack
        } // NavigationLink
    } // body
}

struct LetterAndPictureLinkView: View {
    var body: some View {
        
        HStack {
            
            NavigationLink(destination: LetterView()) {
                Image("letter")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            NavigationLink(destination: PictureView()) {
                Image("photocard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        
    }
}

struct VoiceAndFlowerLinkView: View {
    var body: some View {
        
        HStack {
            
            NavigationLink(destination: VoiceMailView()) {
                Image("cassette")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            NavigationLink(destination: FlowerView()) {
                Image("flower")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        
    }
}

struct GiftBoxView_Previews: PreviewProvider {
    static var previews: some View {
        GiftBoxView()
    }
}
