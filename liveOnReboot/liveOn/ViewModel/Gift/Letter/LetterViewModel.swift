//
//  LetterViewModel.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/07/09.
//

import SwiftUI

struct LetterViewModel {
    static var viewModel: LetterViewModel = LetterViewModel()
  
    var newLetter = Letter()
  
  mutating func updateContent(content: String, completion: (String) -> () ) {
    newLetter.content = content
    completion(newLetter.content)
  }
  
    
  func letterPost(content: String) {
    let param = LetterPostRequest.init(content: content)
        letterMoyaService.request(.postNote(content:param)) { response in
            switch response {
            case .success(let result):
                do {
                    print("Letter Upload \(result)")
                } catch let err {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}


public extension Binding where Value: Equatable {
    init(_ source: Binding<Value?>, replacingNilWith nilProxy: Value) {
        self.init(
            get: { source.wrappedValue ?? nilProxy },
            set: { newValue in
                if newValue == nilProxy {
                    source.wrappedValue = nil
                }
                else {
                    source.wrappedValue = newValue
                }
            })
    }
}
