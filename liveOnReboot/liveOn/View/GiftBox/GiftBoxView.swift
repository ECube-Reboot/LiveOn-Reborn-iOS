//
//  GiftBoxView.swift
//  liveOnReboot
//
//  Created by Boyoung Kim on 2022/07/09.
//

import SwiftUI

struct GiftBoxView: View {
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading, spacing: 12) {
                HStack {
                    CoupleInfoLabel()
                    Spacer()
                    NavigationLink(destination: GiftListView()) {
                        Image("addButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34, alignment: .center)
                    }
                }
                
                CalendarLinkView()
                
                // TODO: 가운데 정렬
                /*
                 
                 캘린더는 가운데에 잘 붙어 있는데,
                 쪽지랑 사진, 음성, 꽃들은 가운데에 안 붙고 왼쪽 정렬되어 있음
                 
                 */
                
                VStack {
                    LetterAndPictureLinkView()
                        .padding(.bottom, 12)
                    VoiceAndFlowerLinkView()
                } // VStack
                
            } // VStack
            .padding(.horizontal)
            .foregroundColor(.textBodyColor)
            
        } // NavigationView
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
                    .offset(y: 2)
                
                // TODO: "유진" -> 유저의 이름이 들어가게 바꿀 것
                Text("유진")
                
                // TODO: "365" -> 설정된 첫 날 부터 앱이 실행되고 있는 시점까지의 날짜 계산해서 넣기
                Text("D+365")
                
            } // HStack
            .font(.TextStyles.handWrittenBody)
            .offset(y: -2)
            
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
                        .font(.TextStyles.mediumCalendarNumber)
                        .offset(y: 12)
                    
                    // TODO: 앱이 실행되는 시점의 달을 숫자로 표시
                    Text("07")
                        .font(.TextStyles.largeCalendarNumber)
                    
                }
                .foregroundColor(.textBodyColor)
                .offset(x: -106)
                
            } // ZStack
        } // NavigationLink
    } // body
}

struct LetterAndPictureLinkView: View {
    var body: some View {
        
        HStack {
            
            NavigationLink(destination: LetterListView()) {
                Image("letter")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: -8, y: 12)
            }
            
            NavigationLink(destination: PictureListView()) {
                Image("photocard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
        } // HStack
    } // body
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
        } // HStack
    }
}

struct GiftBoxView_Previews: PreviewProvider {
    static var previews: some View {
        GiftBoxView()
    }
}
