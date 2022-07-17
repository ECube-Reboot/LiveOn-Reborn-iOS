//
//  PicturePicker.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/10.
//

import SwiftUI
import AVFoundation
import UIKit

struct PicturePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    func makeUIViewController(context: UIViewControllerRepresentableContext<PicturePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PicturePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: PicturePicker
        init(_ parent: PicturePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

enum Picker {
    enum Source: String {
        case library, camera
    }
    
    enum PickerError: Error, LocalizedError {
        case unavailable
        case restricted
        case denied

        var errorDescription: String? {
            switch self {
            case .unavailable:
                return NSLocalizedString("There is no available camera on this device", comment: "")
            case .restricted:
                return NSLocalizedString("You are not allowed to access media capture devices.", comment: "")
            case .denied:
                return NSLocalizedString("You have explicitly denied permission for media capture. Please open permissions/Privacy/Camera and grant access for this application.", comment: "")
            }
        }
    }
    
    static func checkPermissions() throws {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .denied:
                throw PickerError.denied
            case .restricted:
                throw PickerError.restricted
            default:
                break
            }
        } else {
            throw PickerError.unavailable
        }
    }

    struct CameraErrorType {
        let error: Picker.PickerError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK", role: .cancel) {}
    }
}

