//
//  VoicemailViewModel.swift
//  liveOnReboot
//
//  Created by 이성민 on 2022/07/10.
//

import Foundation
import AVFoundation

class VoicemailViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    private var audioRecorder: AVAudioRecorder!
    private var savedPath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    static var voicemailViewModel = VoicemailViewModel()
    
    lazy var fileName: URL = savedPath.appendingPathComponent("live-On : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
    
    var audioPlayer: AVAudioPlayer!
    var recording: Recording?
    var isRecording: Bool = false
    var countSec: Int = 0
    var recordingSec: Int = 0
    var timerCount: Timer?
    var duration: String = ""
    
    @Published var title: String = ""
    @Published var recordingTimeInString: String = "0:00"
    @Published var playingTimeInString: String = ""
    @Published var isRecorded: Bool = false
    @Published var voicemailList = [VoicemailListGetResponse]()
    @Published var singleVoicemail: VoicemailGetResponse?
    @Published var isPlaying: Bool = false
    
    override init() {
        super.init()
        requestMicrophonePermission()
    }
    
    // MARK: - recording 전
    private func requestMicrophonePermission() {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool) -> Void in
            if granted {
                print("Mic: 권한 허용")
            } else {
                print("Mic: 권한 거부")
            }
        })
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
            
            startTimer()
            recordingSec = countSec
            countSec = 0
        } catch {
            print("Failed to setup the recording")
            fatalError()
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        saveRecording()
        timerCount?.invalidate()
    }
    
    // MARK: - recording 후
    func saveRecording() {
        recording = Recording(fileURL: fileName, createdAt: getFileDate(for: savedPath), title: title, duration: duration)
    }
    
    func startPlaying() {
        
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print(error.localizedDescription)
            print("Playing failed in device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileName)
            print(fileName)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("Playing failed: \(error.localizedDescription)")
        }
        
//        playingTimeInString = convertSecToMin(seconds: self.countSec)
//        countSec += 1
//        if countSec <= recordingSec {
//            stopPlaying()
//            timerCount?.invalidate()
//        }
//        countSec = 0
    }
    
    func stopPlaying() {
        audioPlayer.stop()
    }
    
    func playGet(data: Data) {
        
        let playSession = AVAudioSession.sharedInstance()

        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in device")
        }

        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
        } catch {
            print("Playing failed: \(error)")
        }
        // timer 두고 singleVoicemail의 duration을 넘으면 isPlaying을 false로
    }
    
    func downloadVoicemail() {
        let session = URLSession(configuration: .default)
        let url = URL(string: singleVoicemail!.voiceMail)!
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, _, err in
            guard err == nil else {
                print("error: \(String(describing: err))")
                return
            }
            guard let data = data else {
                return
            }
            self.playGet(data: data)
        }
        dataTask.resume()
    }
    
//    MARK: 혹시나 삭제가 필요할수도 있다고 생각해 일단 남겨둠
    func deleteRecording() {
        if (recording != nil) {
            do {
                try FileManager.default.removeItem(at: recording!.fileURL)
            } catch {
                print("Can't delete")
            }
            isRecorded = false
        }
    }
}


// MARK: - api 관련 함수
extension VoicemailViewModel {
    
    func voicemailPost(completion: @escaping () -> ()) {
        if let recording = VoicemailViewModel.voicemailViewModel.recording {
            voicemailMoyaService.request(.voicemailPost(title: title, voicemail: recording, voicemailDuration: duration)) { response in
                switch response {
                case .success:
                    completion()
                case .failure(let err):
                    print(err.localizedDescription)
                    print("---------- 통신 실패 ----------")
                }
            }
        } else {
            print("recording not found")
        }
    }
    
    func voicemailListGet(completion: @escaping () -> ()) async {
        voicemailMoyaService.request(.voicemailListGet) { response in
            switch response {
            case .success(let result):
                do {
                    let data = try result.map([VoicemailListGetResponse].self)
                    self.mapListData(listData: data)
                    completion()
                } catch {
                    print(error.localizedDescription)
                    break
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.voicemailList = []
        }
    }
    
    func voicemailGet(id: Int) {
        voicemailMoyaService.request(.voicemailGet(id: id)) { response in
            switch response {
            case .success(let result):
                do {
                    let data = result.data
                    print("\ndata: \(data.description)\n")
                    let decoder = JSONDecoder()
                    self.singleVoicemail = try decoder.decode(VoicemailGetResponse.self, from: data)
                } catch {
                    print(error)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}


// MARK: - etc 함수
extension VoicemailViewModel {
    func getFileDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
           let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
    
    func convertSecToMin(seconds: Int) -> String {
        let (_, m, s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let sec: String = s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(sec)"
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing")
        isPlaying = false
    }
    
    private func mapListData(listData: [VoicemailListGetResponse]) {
        for data in listData {
            voicemailList.append(data)
        }
    }
    
    private func startTimer() {
        timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.countSec += 1
            self.duration = String(self.countSec)
            self.recordingTimeInString = self.convertSecToMin(seconds: self.countSec)
        })
    }
}
