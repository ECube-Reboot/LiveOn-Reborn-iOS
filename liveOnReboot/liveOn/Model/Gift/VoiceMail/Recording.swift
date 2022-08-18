//
//  Recording.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/08/18.
//

import Foundation

struct Recording: Equatable {
    
    let fileURL: URL
    let createdAt: Date
    let title: String
    let duration: String
    
}
