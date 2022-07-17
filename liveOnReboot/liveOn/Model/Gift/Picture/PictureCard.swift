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
