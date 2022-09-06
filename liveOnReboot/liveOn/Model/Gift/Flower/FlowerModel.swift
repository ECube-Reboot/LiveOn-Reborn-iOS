//
//  FlowerModel.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/11.
//

import Foundation
import SwiftUI

class FlowerGift: Identifiable, ObservableObject {

    @Published var flower: Flower?

    let id: UUID
    let createdDate: String
    let writer : String
    var message : String

    init(flower: Flower, createdDate: String, writer: String, message: String) {
        id = UUID()
        self.flower = flower
        self.writer = writer
        self.createdDate = createdDate
        // DateToString 함수 필요
        self.message = message
    }
}

struct FlowerPopUp: View {
    let content : FlowerGift
    var body: some View {
        Image(content.flower!.imageFileName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
    }
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
                    }
                } label: {
                    VStack(spacing: 4) {
                        // TODO: Server
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

                        setFlowerMessage()

                    } // VStack
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } // VStack
            } // VStack
        } // ZStack
    } // body
    private func setFlowerMessage() -> some View {
        ZStack {
            VStack(alignment: .center, spacing: 4) {
                // TODO: Server
                Text(flowerList[cardIndex].message)
                    .padding()
                // TODO: Server
                Text("20220613")

            }
            .frame(width: 280, height: 240, alignment: .center)
            .foregroundColor(.textBodyColor)
            .background(
                // TODO: Server
                Image("letter_yellow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity))
        }
    }
}
#if DEBUG
let flowerList = FlowerGift.dummyData()
#endif
// 더미데이터
#if DEBUG
extension FlowerGift {

    static func dummyData() -> [FlowerGift] {

        return [
            FlowerGift(flower: Flower.angae,
                       createdDate: "2022-07-10",
                       writer: "재헌",
                       message: "엄지 손가락으로 장미꽃을 피워"),
            FlowerGift(flower: Flower.angae,
                       createdDate: "2022-07-10",
                       writer: "재헌",
                       message: "엄지 손가락으로 장미꽃을 피워"),
            FlowerGift(flower: Flower.angae,
                       createdDate: "2022-07-10",
                       writer: "재헌",
                       message: "엄지 손가락으로 장미꽃을 피워"),
            FlowerGift(flower: Flower.angae,
                       createdDate: "2022-07-10",
                       writer: "재헌",
                       message: "엄지 손가락으로 장미꽃을 피워")
        ]
    }
}
#endif
