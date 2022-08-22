//
//  FlowerView.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/17.
//

import SwiftUI

// FlowerListView로 바꿔야..
struct FlowerView: View {
        
    var body: some View {
        
        VStack {
            Text("주고 받은 꽃들을 볼 수 있는 뷰")
            
        } // VStack
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
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView()
    }
}
