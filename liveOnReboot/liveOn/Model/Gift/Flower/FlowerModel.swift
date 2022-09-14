//
//  FlowerModel.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/11.
//

import Foundation
import SwiftUI

struct FlowerPopUp: View {
    let content : String
    var body: some View {
        Image(content)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
    }
}

struct FlowerPopUpView: View {

    var imageName: String
    var comment: String
    @Binding var popUpBoolean: Bool
    @Binding var cardIndex: Int

    var body: some View {

        ZStack {
            VStack(alignment: .center) {
                Button {
                    withAnimation(.linear(duration: 0.24)) {
                        popUpBoolean.toggle()
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(imageName)
                            .resizable()
                            .rotationEffect(.degrees(90))
                            .padding()
                            .frame(width: 300, height: 260, alignment: .center)

                        Text(imageName)
                            .font(.title3)
                            .foregroundColor(.textBodyColor)
                            .fontWeight(.bold)

                        setFlowerMessage(comment: comment)

                    } // VStack
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } // VStack
            } // VStack
        } // ZStack
    } // body
    private func setFlowerMessage(comment: String) -> some View {
        ZStack {
            Text(comment)
                .foregroundColor(.black)
                .padding()
                .frame(width: 280, height: 240, alignment: .center)
                .background(
                    Image("letter_yellow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity))
        }
    }
}

//#if DEBUG
//let flowerList = FlowerGift.dummyData()
//#endif
//// 더미데이터
//#if DEBUG
//extension FlowerGift {
//
//    static func dummyData() -> [FlowerGift] {
//
//        return [
//            FlowerGift(flower: Flower.angae,
//                       createdDate: "2022-07-10",
//                       writer: "재헌",
//                       message: "엄지 손가락으로 장미꽃을 피워"),
//            FlowerGift(flower: Flower.angae,
//                       createdDate: "2022-07-10",
//                       writer: "재헌",
//                       message: "엄지 손가락으로 장미꽃을 피워"),
//            FlowerGift(flower: Flower.angae,
//                       createdDate: "2022-07-10",
//                       writer: "재헌",
//                       message: "엄지 손가락으로 장미꽃을 피워"),
//            FlowerGift(flower: Flower.angae,
//                       createdDate: "2022-07-10",
//                       writer: "재헌",
//                       message: "엄지 손가락으로 장미꽃을 피워")
//        ]
//    }
//}
//#endif
