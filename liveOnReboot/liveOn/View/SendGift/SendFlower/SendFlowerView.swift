//
//  SendFlowerView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/10.
//

import SwiftUI

struct SendFlowerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var showAlertforSend: Bool = false
    @State var isValidate = false

    var body: some View {
        VStack {
            
            // TODO:  이미지를 받아 넣는 곳
            tempCard(cardName: "오늘의 꽃 이미지")
            
            // TODO: 쪽지 이미지
            tempCard(cardName: "쪽지 이미지\n&\n텍스트 필드")
            
        } // VStack
        .navigationToBack(dismiss)

    } // body
}

struct tempCard: View {
    
    let cardName: String
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .stroke()
                .frame(width: 360, height: 160, alignment: .center)
            Text(cardName)
            
        } // ZStack
    } // body
}

struct SendFlowerView_Previews: PreviewProvider {
    static var previews: some View {
        SendFlowerView()
    }
}
