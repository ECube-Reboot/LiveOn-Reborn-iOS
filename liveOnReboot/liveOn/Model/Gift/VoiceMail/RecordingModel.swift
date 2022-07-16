//
//  RecordingModel.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/07/16.
//

import Foundation

struct Recording {
    
    let fileURL: URL
    let createdAt: Date
    let title: String
    let duration: String
    var isPlaying: Bool
    
}
