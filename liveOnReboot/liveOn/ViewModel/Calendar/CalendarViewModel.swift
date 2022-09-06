//
//  CalendarViewModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/08/02.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    @ObservedObject static var viewModel: CalendarViewModel = CalendarViewModel()
    @Published var calendarList = CalendarMainGet()
    @Published var boxList = CalendarDayResponse()
    func checkGift() -> Bool {
        if !boxList.audioResponseList.isEmpty { return true }
        if !boxList.noteResponseList.isEmpty { return true }
        if !boxList.polaroidResponseList.isEmpty { return true }
        if !boxList.flowerResponseList.isEmpty {return true }
        return false
    }
    func calendarMainPost(upcomingEventdate: String, upcomingEventTitle: String, upcomingEventMemo: String, completion: @escaping () -> ()) {
        let param = CalendarMainPostRequest.init(upcomingEventdate: upcomingEventdate, upcomingEventTitle: upcomingEventTitle, upcomingEventMemo: upcomingEventMemo)
        calendarMainMoyaService.request(.postCalendarMain(content:param)) { response in
            switch response {
                case .success(_):
                    Task {
                        await self.calendarMainGet(month: upcomingEventdate, completion: {
                           completion()
                        })
                    }
                    return
                case .failure(let err):
                    print("Post에 실패했습니다")
                    print(err.localizedDescription)
            }
        }
    }
    
    func calendarMainGet(month: String, completion: @escaping () -> ()) async {
        calendarMainMoyaService.request(.getCalendarMain(calendarRequest: month)) { response in
            switch response {
                case .success(let result):
                    print("받아온 response는 다음과 같다 \(result)")
                    do {
                        let data = try result.map(CalendarMainGet.self)
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
    
    private func mapListData(listData: CalendarMainGet) {
        calendarList = listData
    }
    
    func calendarDayGet(month: String, completion: @escaping () -> ()) async {
        calendarMainMoyaService.request(.getCalendarDay(calendarRequest: month)) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map(CalendarDayResponse.self)
                        self.boxList = data
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

//    private func judgeLoginStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
//        let decoder = JSONDecoder()
//        guard let decodedData = try? decoder.decode(GenericResponse<CalendarDayResponse>.self, from: data)
//        else {
//            return .pathErr
//        }
//
//        switch statusCode {
//        case 200:
//            return .success(decodedData.data ?? "None-Data")
//        case 400..<500:
//            return .requestErr(decodedData.message)
//        case 500:
//            return .serverErr
//        default:
//            return .networkFail
//        }
//    }

}

struct GenericResponse<T: Codable>: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case status, success, message, data
    }
}

