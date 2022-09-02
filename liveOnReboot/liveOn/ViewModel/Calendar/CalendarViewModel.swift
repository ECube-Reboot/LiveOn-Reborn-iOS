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
}
