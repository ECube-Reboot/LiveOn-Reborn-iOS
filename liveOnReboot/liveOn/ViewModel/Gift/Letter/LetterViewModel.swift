//
//  LetterViewModel.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/07/09.
//

import SwiftUI

class LetterViewModel: ObservableObject {
  static var viewModel: LetterViewModel = LetterViewModel()
  
  var newLetter = Letter()
  @Published var letterList = [LetterGet]()
  func updateContent(content: String, completion: (String) -> () ) {
    newLetter.content = content
    completion(newLetter.content)
  }
  
  func letterPost(content: String) {
    let param = LetterPostRequest.init(content: content)
    letterMoyaService.request(.postNote(content:param)) { response in
      switch response {
        case .success(_):
          return
        case .failure(let err):
          print(err.localizedDescription)
      }
    }
  }
  
  func letterListGet() async {
    letterMoyaService.request(.getNotes) { response in
      switch response {
        case .success(let result):
          do {
            let data = try result.map([LetterGet].self)
            self.mapListData(listData: data)
            
          } catch let err {
            print(err.localizedDescription)
            break
          }
        case .failure(let err):
          print(err.localizedDescription)
      }
    }
  }
  
  private func mapListData(listData: [LetterGet]) {
    for data in listData {
      letterList.append(data)
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
