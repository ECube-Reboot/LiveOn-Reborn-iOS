//
//  CalendarViewModel.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/08/02.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    static var viewModel: CalendarViewModel = CalendarViewModel()
    
    @Published var list: [UpcomingEventsModel]
    @Published var calendarList = [CalendarMainGet]()

    init() {
        list = []
    }
    
    func calendarMainPost(upcomingEventdate: String, upcomingEventTitle: String, upcomingEventMemo: String) {
        let param = CalendarMainPostRequest.init(upcomingEventdate: upcomingEventdate, upcomingEventTitle: upcomingEventTitle, upcomingEventMemo: upcomingEventMemo)
        calendarMainMoyaService.request(.postCalendarMain(content:param)) { response in
            switch response {
                case .success(_):
                    print("Post에 성공했습니다")
                    return
                case .failure(let err):
                    print("Post에 실패했습니다")
                    print(err.localizedDescription)
            }
        }
    }
    
    func calendarMainGet(completion: @escaping () -> ()) async {
        calendarMainMoyaService.request(.getCalendarMain) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map([CalendarMainGet].self)
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
    
    private func mapListData(listData: [CalendarMainGet]) {
        for data in listData {
            calendarList.append(data)
        }
    }
    
    func insert(upcomingEventDate: Date, upcomingEventTitle: String, upcomingEventMemo: String) {
        list.insert(UpcomingEventsModel(upcomingEventDate: upcomingEventDate, upcomingEventTitle: upcomingEventTitle, upcomingEventMemo: upcomingEventMemo), at: 0)
    }
    
    
}
