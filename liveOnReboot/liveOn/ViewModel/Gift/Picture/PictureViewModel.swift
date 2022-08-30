//
//  PictureViewModel.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/10.
//

import SwiftUI
import Foundation
import Combine

final class PictureViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    @Published var showCameraAlert = false
    @Published var cameraError: Picker.CameraErrorType?
    @Published var imageName: String = ""
    @Published var myImages: [MyPicture] = []
    @Published var loadedImageList: [PictureGetResponse] = []
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkPermissions()
            }
            showPicker = true
        } catch {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
    
    func reset() {
        image = nil
        imageName = ""
    }
    
    func imageListGet(_ completion: @escaping () -> ()) {
        moyaService.request(.imageListGet) { response in
            switch response {
            case .success(let result):
                do {
                    let data = try result.map([PictureGetResponse].self)
                    print("Data : \(data)")
                    for element in data {
                        self.loadedImageList.append(element)
                    }
                    
                } catch let err {
                    print(err.localizedDescription)
                    print("Failed to decode the image list")
                    break
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        completion()
    }
}

final class KeyboardHandler: ObservableObject {
    @Published private(set) var keyboardHeight: CGFloat = 0
    
    private var cancellabel: AnyCancellable?
    
    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }
    
    init() {
        cancellabel = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: DispatchQueue.main)
            .assign(to: \.self.keyboardHeight, on: self)
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
