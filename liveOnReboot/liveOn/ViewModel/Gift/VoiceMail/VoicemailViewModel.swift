//
//  VoicemailViewModel.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/07/10.
//

import Foundation
import AVFoundation

class VoicemailViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
}
