//
//  GiftListView.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/09.
//

import SwiftUI

struct GiftListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationView{
            VStack {
                Image("cassetteIcon04")
                
                ZStack {
                Image("bubble")
                    Text("오늘은 어떤 선물을 보내볼까요?")
                        
                }
                
            }
            .navigationToBack(dismiss)
            
        } // NavigationView
    } // body
}

struct CardWithStroke: View {
    
    let cardName: String
    let cardImage: String
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .stroke()
                .frame(width: 360, height: 160, alignment: .center)
            Text(cardName)
            
        } // ZStack
    } // body
}

struct GiftListView_Previews: PreviewProvider {
    static var previews: some View {
        GiftListView()
    }
}
