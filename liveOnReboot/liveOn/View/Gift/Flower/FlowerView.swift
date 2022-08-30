//
//  FlowerView.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/17.
//

import SwiftUI

struct FlowerListView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var showFlowerPopUp = false
    @State var selectedCardIndex = 0
    
    // instance 관련 오류로 인해 잠시 주석 처리
    // let rotation: Double = calculateImageRotationAngle(index: cardIndex)
    
    let columns : [GridItem] = [
        GridItem(.flexible(), spacing: -10, alignment: .bottom),
        GridItem(.flexible(), spacing: 20, alignment: .top)
    ]
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                
                Text("꽃을 눌러 상세 정보를 확인할 수 있어요")
                    .foregroundColor(.textBodyColor)
                
                Spacer()
                
                ZStack(alignment: .center) {
                    // 꽃병
                    Image("backgroundForVase")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: Color.shadowColor, radius: 2, x: 0, y: 0)
                        .padding(24)
                    
                    Circle().fill(.white).frame(width: 160,
                                                height: 160,
                                                alignment: .center)
                    
                    Circle()
                        .fill(.regularMaterial)
                        .padding()
                        .overlay(
                            Circle().fill(.gray).frame(width: 100,
                                                       height: 100,
                                                       alignment: .center).opacity(0.9)
                        )
                    
                    LazyVGrid(columns: columns, spacing: -40) {
                        ForEach(0..<flowerList.count, id: \.self) { index in
                            FlowerPopUp(content: flowerList[index])
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                        showFlowerPopUp = true
                                        selectedCardIndex = index
                                    }
                                }
                        }
                    }
                    .padding()
                    
                } // ZStack
                
                Text("이전에 받은 꽃은\n달력에서 확인할 수 있어요.")
                    .foregroundColor(Color(uiColor: .systemGray2))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                
            } // VStack
            .blur(radius: showFlowerPopUp ? 6 : 0)
            Color(uiColor: .systemBackground).opacity(showFlowerPopUp ? 0.8 : 0)
            
            if showFlowerPopUp {
                FlowerPopUpView(popUpBoolean: $showFlowerPopUp, cardIndex: $selectedCardIndex)
            }
            
        } // ZStack
        
        .navigationToBack(dismiss)
        .navigationTitle("꽃")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.background)
        
    } // body
}

struct FlowerPopUpView: View {
    
    @Binding var popUpBoolean: Bool
    @Binding var cardIndex: Int
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center) {
                Button {
                    
                    withAnimation(.linear(duration: 0.24)) {
                        popUpBoolean.toggle()
                    } // Button
                    
                } label: {
                    
                    VStack(spacing: 4) {
                        
                        Image(flowerList[cardIndex].flower!.imageFileName)
                            .resizable()
                            .rotationEffect(.degrees(90))
                            .padding()
                            .frame(width: 300, height: 260, alignment: .center)
                        
                        // TODO: 꽃 이름이 한글로 뜰 수 있게 수정할 것
                        Text(flowerList[cardIndex].flower!.imageFileName)
                            .font(.title3)
                            .foregroundColor(.textBodyColor)
                            .fontWeight(.bold)
                        
                        Text(flowerList[cardIndex].message)
                            .font(.subheadline)
                            .foregroundColor(.textBodyColor)
                            .opacity(0.9)
                            .padding(.bottom, 32)
                        
                        ZStack {
                            // 쪽지
                            VStack(alignment: .center, spacing: 4) {
                                Text(flowerList[cardIndex].message)
                                    .padding()
                                Text("20220613")
                                
                            }
                            .frame(width: 280, height: 240, alignment: .center)
                            .foregroundColor(.textBodyColor)
                            .background(
                                Image("letter_yellow")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity))
                        }
                        
                    } // VStack
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } // VStack
            } // VStack
        } // ZStack
    } // body
}

struct FlowerListView_Previews: PreviewProvider {
    static var previews: some View {
        
        FlowerListView()
        
    }
}

extension FlowerListView {
    
    struct FlowerPopUp: View {
        
        let content : FlowerGift
        
        var body: some View {
            Image(content.flower!.imageFileName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
    }
}

#if DEBUG
let flowerList = FlowerGift.dummyData()
#endif
