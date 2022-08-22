//
//  FlowerModel.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/11.
//

import Foundation

enum Flower {
    
    case angae
    // 안개꽃
    case freesia
    // 프리지아
    case keum
    // 금목서
    case larkspur
    // 수국
    case lisianthius
    // 리시안셔스
    
}

class FlowerGift: Identifiable, ObservableObject {
    
    let id: UUID
    @Published var flower: Flower?
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
                       message: "엄지 손가락으로 장미꽃을 피워")]
    }
}
#endif
