//
//  Picture.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/10.
//


import Foundation

struct PhotoCardInformation: Hashable {
    
    var imageName: String
    var photoText: String
    
}

struct PhotoGiftData: Hashable {
    
    var photoURL: String
    var photoComment: String
    
}

// Sample data
var temporaryData: [PhotoCardInformation] = [
    
    PhotoCardInformation(
        imageName: "photo_dinner",
        photoText: "첫 저녁 식사"),
    // 사진 출처 : https://unsplash.com/photos/Jh-3BU7C014
    
    PhotoCardInformation(
        imageName: "photo_picnic",
        photoText: "날씨 좋다고 즉흥으로 소풍갔던 날"),
    // 사진 출처 : https://unsplash.com/photos/NdcH-WxzWgo
    
    PhotoCardInformation(
        imageName: "photo_wedding",
        photoText: "추억의 컨셉 사진"),
    // 사진 출처 : https://unsplash.com/photos/w5hhoYM_JsU
    
    PhotoCardInformation(
        imageName: "photo_flower",
        photoText: "별 보러 갔던 날"),
    // 사진 출처 : https://unsplash.com/photos/Ggv3i6oxPcg
    
    PhotoCardInformation(
        imageName: "photo_plant",
        photoText: "우리가 같이 키운 자식"),
    // 사진 출처 : https://unsplash.com/photos/UcfKYTan-LU
    
    PhotoCardInformation(
        imageName: "photo_sand",
        photoText: "우리가 같이 키운 자식")
    // 사진 출처 : https://unsplash.com/photos/FHT0KEOwtyg
]
