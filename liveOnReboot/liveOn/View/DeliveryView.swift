//
//  PictureDeliveryView.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/10.
//


import SwiftUI

struct GiftDeliveryView: View {
    
//    @Environment(\.dismiss) private var dismiss
    @Binding var gotoMain: Bool
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 20) {
                Image("successMatching")
                    .resizable()
                    .frame(width: 240, height: 260)
                
                VStack {
                    Text("상대방에게 선물이 배송되었어요!")
                        .font(.system(size: 18))
                        .foregroundColor(.mainBrown)
                        .padding(.vertical)

                    NavigationLink(destination: GiftBoxView()) {
                        Text("보관함으로 돌아가기")
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .frame(width: 300, height: 60, alignment: .center)
                            .background(Color.crimson)
                            .cornerRadius(12)
                    }
//                    Button {
//                        print("바인딩된 변수에 저장된 값을 다음과 같습니다")
//                        print(gotoMain)
//                        gotoMain = false
////                        dismiss()
//                    } label: {
//                        Text("보관함으로 돌아가기")
//                            .foregroundColor(.white)
//                            .bold()
//                            .padding()
//                            .frame(width: 300, height: 60, alignment: .center)
//                            .background(Color.crimson)
//                            .cornerRadius(12)
//                    }
                }
            }
        }
        .navigationTitle("배송완료")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .background(.background)
        .ignoresSafeArea()
    }
}
