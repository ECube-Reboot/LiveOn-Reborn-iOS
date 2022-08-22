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
            }
            .navigationToBack(dismiss)
        } // NavigationView
    } // body
}

struct TempCard: View {
    
    let cardName: String
    let
    
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
