//
//  SendFlowerView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/10.
//

import SwiftUI

struct SendFlowerView: View {
    var body: some View {
        VStack {
            
            // TODO:  이미지를 받아 넣는 곳
            TempCard(cardText: "오늘의 꽃 이미지")
            
            // TODO: 쪽지 이미지
            TempCard(cardText: "쪽지 이미지\n&\n텍스트 필드")
            
        } // VStack
    } // body
}

struct TempCard: View {
    
    let cardText: String
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .stroke()
                .frame(width: 360, height: 160, alignment: .center)
            Text(cardText)
            
        } // ZStack
    } // body
}

struct SendFlowerView_Previews: PreviewProvider {
    static var previews: some View {
        SendFlowerView()
    }
}
