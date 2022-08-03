//
//  PicturePicker.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/10.
//


import Foundation
import SwiftUI

struct MyPicture: Identifiable, Codable {
    var id = UUID()
    var name: String
}

enum MyPictureError: Error, LocalizedError {
    case readError
    case decodingError
    case encodingError
    case saveError
    case saveImageError
    case readImageError
    
    var errorDescription: String? {
        switch self {
        case .readError:
            return NSLocalizedString("Could not load MyImage.json, please reinstall the app.", comment: "")
        case .decodingError:
            return NSLocalizedString("There was a problem loading your list of images, please create a new image to start over.", comment: "")
        case .encodingError:
            return NSLocalizedString("Could not save your MyImage data, please reinstall the app.", comment: "")
        case .saveError:
            return NSLocalizedString("Could not save the My Image json file.  Please reinstall the app.", comment: "")
        case .saveImageError:
            return NSLocalizedString("Could not save image.  Please reinstall the app.", comment: "")
        case .readImageError:
            return NSLocalizedString("Could not load image.  Please reinstall the app.", comment: "")
        }
    }
    
    struct ErrorType: Identifiable {
        let id = UUID()
        let error: MyPictureError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK", role: .cancel) {}
    }
}
