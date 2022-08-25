//
//  APITEST.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/08/24.
//

import SwiftUI

struct APITEST: View {
    @State private var apiTestData = ApiDataSet()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(apiTestData.text)
                    .font(.largeTitle.bold())
                    .foregroundColor(.indigo)
            }
            .task {
                await fetchData2()
            }
        }
    }
    
    // async를 통해 비동기 함수임을 나타냄. 비동기가 뭐고 왜 get 작업을 비동기로 해야하는지는
    // https://sujinnaljin.medium.com/swift-async-await-concurrency-bd7bcf34e26f 이 링크를 참고해주세요
    func fetchData2() async {
        // 데이터를 가져올 url을 만듭니다. url를 만드는것은 기본 제공 URL 스트럭트를 사용하면됩니다
        guard let url = URL(string: "http://13.124.90.96:8080/api/v1/testing/test") else {
            print("hey man This URL Does not work")
            return
        }
        // URL로부터 데이터를 받아옵니다.
        do {
            // await 비동기함수의 실행을 동기화 시키라는 말이다
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // 서버로 받은 제이슨 형태 파일을 decode해서 객체화시킴
            if let decodedResponse = try? JSONDecoder().decode(ApiDataSet.self, from: data) {
                print("Response data raw: \(data)")
                print("fetch Data")
                print("Decoded Response \(decodedResponse)")
                apiTestData = decodedResponse
            }
        } catch {
            print("bad news! this data isn't valid")
        }
    }
}

struct ApiDataSet: Codable{
    var text: String = ""
}

struct APITEST_Previews: PreviewProvider {
    static var previews: some View {
        APITEST()
    }
}
