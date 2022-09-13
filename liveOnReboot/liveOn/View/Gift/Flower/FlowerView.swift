//
//  FlowerView.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/17.
//

import SwiftUI

// FlowerListView로 바꿔야..
struct FlowerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            Text("꽃을 눌러 상세를 볼 수 있어요.")
            Spacer()
            
            // TODO: 사용자가 주고 받은 꽃들을 ZStack과 Grid를 이용해 표시
            // TODO: 빈 꽃병 에셋 추가
            
            Image("flower")
                .padding(.horizontal, 12)
            
            Spacer()
            Text("더 이전의 꽃은\n달력에서 확인할 수 있어요.")
                .multilineTextAlignment(.center)
            Spacer()
            
        } // VStack
        .navigationToBack(dismiss)
        .navigationTitle("꽃")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SendFlowerView()) {
                    Image("addButton")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        
    } // body
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView()
    }
}
