//
//  Flower.swift
//  liveOnReboot
//
//  Created by 김보영 on 2022/07/11.
//

import Foundation

enum Flower {
    case rose
    case sunflower
    case dandelion
}

class FlowerGift: Identifiable, ObservableObject {
    
    let id: UUID
    @Published var flower: Flower?
    let createdDate: String
    let writer : String
    let message : String
    
    init(flower: Flower, createdDate: String, writer: String, message: String) {
        
        id = UUID()
        self.flower = flower
        self.writer = writer
        self.createdDate = createdDate
        // DateToString 함수 필요
        self.message = message
        
    }
}

var sampleData: [FlowerGift] = [
    FlowerGift(flower: Flower.rose, createdDate: "220707", writer: "재헌", message: "엄지 손가락으로 장미꽃을 피워"),
    FlowerGift(flower: Flower.rose, createdDate: "220707", writer: "재헌", message: "엄지 손가락으로 장미꽃을 피워"),
    FlowerGift(flower: Flower.rose, createdDate: "220707", writer: "재헌", message: "엄지 손가락으로 장미꽃을 피워")
]
