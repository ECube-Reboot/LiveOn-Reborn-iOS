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
    var playingURL: URL?
    var recording: Recording?
    let savedPath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    @Published var title: String = ""
    
    override init() {
        super.init()
        fetchRecording()
    }
    
    // MARK: - recording 전
    func fetchRecording() {
        let directoryContent = try! FileManager.default.contentsOfDirectory(at: savedPath, includingPropertiesForKeys: nil)[0]
        recording = Recording(fileURL: directoryContent, createdAt: getFileDate(for: directoryContent), title: title, duration: "")
    }
    
    // MARK: - recording 중
    func startRecording() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Cannot setup the recording")
            fatalError()
        }
        
        let fileName = savedPath.appendingPathComponent("live-On : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            
        } catch {
            print("Failed to setup the recording")
            fatalError()
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
    }
    
    // MARK: - recording 후
    func startPlaying(url: URL) {
        
        playingURL = url
        
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("Playing failed")
        }
    }
    
    func stopPlaying(url: URL) {
        audioPlayer.stop()
    }
    
    func deleteRecording(url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't delete")
        }
    }
    
    // MARK: - etc 함수
    func getFileDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
           let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
}
