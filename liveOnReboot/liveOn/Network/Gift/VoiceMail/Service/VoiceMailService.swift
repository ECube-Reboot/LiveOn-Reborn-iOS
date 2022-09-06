//
//  VoiceMailService.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import Foundation
import SwiftUI
import Moya

let voicemailMoyaService = MoyaProvider<VoicemailServerCommunication>(plugins: [NetworkLoggerPlugin()])

enum VoicemailServerCommunication {
    case login(param: LoginRequestDTO)
    case voicemailPost(title: String, voicemail: Recording, voicemailDuration: String)
    case voicemailListGet
    case voicemailGet(id: Int)
}
