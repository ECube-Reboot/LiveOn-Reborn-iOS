//
//  LetterService.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI
import Moya

let letterMoyaService = MoyaProvider<LetterServerCommunication>(plugins: [NetworkLoggerPlugin()])

enum LetterServerCommunication {
    case getNotes
    case postNote(content: LetterPostRequest)
}
