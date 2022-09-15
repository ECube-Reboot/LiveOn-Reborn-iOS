//
//  FlowerViewModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

class FlowerViewModel: ObservableObject {
    static var viewModel: FlowerViewModel = FlowerViewModel()
    @Published var flowerList = [FlowerGetResponse]()
    @Published var flowerListExtracted = [FlowerGetResponse]()

    func flowerPost(flowerName: String, message: String, completion: () -> ()) {
        let param = FlowerPostRequest(flowerName: flowerName, message: message)
        flowerMoyaService.request(.postFlower(content: param)) { response in
            switch response {
            case .success(_):
                print("Post 성공!")
                return
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        completion()
    }

    func flowerListGet(completion: @escaping () -> ()) {
        flowerMoyaService.request(.getFlower) { response in
            switch response {
            case .success(let result):
                do {
                    let data = try result.map([FlowerGetResponse].self)
                    self.mapListData(listData: data)
                    if self.flowerList.count > 4 {
                        var tempArray: [FlowerGetResponse] = []
                        var i = 0
                        while i < 4 {
                            tempArray.append(self.flowerList[i])
                            i += 1
                        }
                        self.flowerListExtracted = tempArray
                    }
                    completion()

                } catch let err {
                    print("디코딩 에러 발생")
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print("통신 실패")
                print(err.localizedDescription)
            }
        }
        DispatchQueue.main.async {
            self.flowerList = []
        }
    }

    private func mapListData(listData: [FlowerGetResponse]) {
        for data in listData {
            flowerList.append(data)
        }
    }
}

enum Flower: CaseIterable {
    case angae, freesia, keum, larkspur, lisianthius
    var imageFileName: String {
        switch self {
        case .angae:
            return "angae"
        case .freesia:
            return "freesia"
        case .keum:
            return "keum"
        case .larkspur:
            return "larkspur"
        case .lisianthius:
            return "lisianthius1"
        }
    }
}


func getRandomFlower() -> String {
    let getRandomFlower = Flower.allCases.randomElement()!.imageFileName
    return getRandomFlower
}

func getFlowerPhrase(flowerName: String) -> String {
    switch flowerName {
    case "angae":
        return "맑고 깨끗한 마음"
    case "freesia":
        return "천진난만함"
    case "keum":
        return " 진정한 사랑"
    case "larkspur":
        return "청명과 자유"
    case "lisianthius1":
        return "변치않는 사랑"
    default :
        return "Empty"
    }
}
