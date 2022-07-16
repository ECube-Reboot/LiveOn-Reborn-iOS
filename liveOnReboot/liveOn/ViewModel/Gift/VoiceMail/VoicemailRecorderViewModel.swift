//
//  VoicemailRecorderViewModel.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/07/16.
//

import Foundation
import AVFoundation

class VoicemailRecorderViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    var isRecording: Bool {
        return self.audioRecorder.isRecording
    }
    
    override init() {
        super.init()
    }
    
}
