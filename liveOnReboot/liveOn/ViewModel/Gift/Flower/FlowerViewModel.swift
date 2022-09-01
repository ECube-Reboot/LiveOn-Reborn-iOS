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

    func flowerPost(color: String, content: String) {
        let param = FlowerPostRequest(flowerId: "", message: "")
        flowerMoyaService.request(.postFlower(content: FlowerPostRequest)) { response in
            switch response {
                case .success(_):
                    return
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }

    func flowerListGet(completion: @escaping () -> ()) {
        flowerMoyaService.request(.getFlower) { response in
            switch response {
                case .success(let result):
                    do {
                        print("데이터 수신 성공")
                        let data = try result.map([FlowerGetResponse].self)
                        self.mapListData(listData: data)
                        print("저장된 꽃 데이터는 다음과 같습니다 \(self.flowerList)")
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
    }

    private func mapListData(listData: [FlowerGetResponse]) {
        for data in listData {
            flowerList.append(data)
        }
    }
}

enum Flower {
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
        default:
            return "lisianthius"
        }
    }
}
