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
    func updateContent(color: String, content: String, posting: (String,String) -> (), completion: () -> () ) {
        newLetter.color = color
        newLetter.content = content
        posting(newLetter.color, newLetter.content)
        completion()
    }
    
    func letterPost(color: String, content: String) {
        let param = LetterPostRequest.init(color: color, content: content)
        letterMoyaService.request(.postNote(content:param)) { response in
            switch response {
                case .success(_):
                    return
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func letterListGet(completion: @escaping () -> ()) async {
        letterMoyaService.request(.getNotes) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map([LetterGet].self)
                        self.mapListData(listData: data)
                        completion()
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
                } else {
                    source.wrappedValue = newValue
                }
            })
    }
}
