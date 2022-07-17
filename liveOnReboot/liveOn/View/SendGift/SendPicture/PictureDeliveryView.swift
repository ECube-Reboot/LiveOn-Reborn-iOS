//
//  PictureDeliveryView.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/10.
//


import SwiftUI

struct PictureDelivery: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var gotoMain: Bool
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 20) {
                
                // TODO: 스케치 이미지 빼고 제대로 된 일러스트 작업해서 넣기
                Image("successMatching")
                    .resizable()
                    .frame(width: 240, height: 260)
                
                VStack {
                    
                    Text("상대방에게 선물이 배송되었어요!")
                        .font(.system(size: 18))
                        .foregroundColor(.mainBrown)
                        .padding(.vertical)
                    
                    Button {
                        gotoMain = false

                    } label: {
                        Text("보관함으로 돌아가기")
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .frame(width: 300, height: 60, alignment: .center)
                            .background(Color.crimson)
                            .cornerRadius(12)
                    }
                    
                } // VStack
            } // VStack
        } // ZStack
        .navigationTitle("배송완료")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .background(.background)
        .ignoresSafeArea()
        
    } // body
}
