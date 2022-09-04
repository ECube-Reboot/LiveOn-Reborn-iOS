//
//  GiftListView.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/09.
//

import SwiftUI

struct GiftListView: View {
    
    // 테스트용 임시
    @State var tempGotoMain = false
        
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        LazyVStack(alignment: .leading, spacing: 6) {
            Image("cassetteIcon04")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
                .scaledToFill()
                .offset(x: UIScreen.main.bounds.width * 0.04)
            
            ZStack {
                Image("bubble")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.68, height: UIScreen.main.bounds.width * 0.24)
                Text("오늘은 어떤 선물을 보내볼까요?")
                    .offset(y: 4)
            } // ZStack
            
            LazyVStack(alignment: .trailing, spacing: 16) {
                
                // TODO: 카드 내 이미지와 텍스트 왼쪽 정렬
                
                NavigationLink(destination: SendLetterView(gotoMain: $tempGotoMain)) {
                    CardWithStroke(cardName: "쪽지", cardImage: "letterIcon")
                }
                NavigationLink(destination: SendPictureView(gotoMain: $tempGotoMain)) {
                    CardWithStroke(cardName: "폴라로이드", cardImage: "photocardIcon")
                }
                NavigationLink(destination: SendVoicemailView(gotoMain: $tempGotoMain)) {
                    CardWithStroke(cardName: "음성메세지", cardImage: "casetteIcon")
                }
                NavigationLink(destination: SendFlowerView()) {
                    CardWithStroke(cardName: "꽃", cardImage: "flowerIcon")
                }
                
            } // VStack 우측 제작뷰 이동 버튼 스택
            .padding(.top, 12)
            
            Spacer()
            
        } // VStack
        .font(.TextStyles.handWrittenBody)
        .foregroundColor(.textBodyColor)
        .navigationTitle("선물 목록")
        .navigationBarTitleDisplayMode(.inline)
        .navigationToBack(dismiss)
        .padding(.horizontal)
        
    } // body
}

struct CardWithStroke: View {
    
    let cardName: String
    let cardImage: String
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke()
                .foregroundColor(Color.placeHolderColor)
                .frame(width: UIScreen.main.bounds.width * 0.48, height: UIScreen.main.bounds.height * 0.1, alignment: .center)
                .background(.white)
            

                HStack {
                    Image(cardImage)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2, alignment: .center)
                        .offset(y: 0)
                    
                    Text(cardName)
                        .multilineTextAlignment(.leading)
            } // HStack
        } // ZStack
    } // body
}

struct GiftListView_Previews: PreviewProvider {
    static var previews: some View {
        
        GiftListView()
        
    }
}
