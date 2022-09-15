//
//  CalendarView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct CalendarView: View {
    // 기본 베이스가 되는 날짜 변수
    @State var currentDate: Date = Date.now
    
    // 기념일 추가 Button
    @State var showSheet = false
    
    // PopupDate 아래에 블러 효과 넣기
    @State private var isClicked = false
    
    // 달력에서 PopupDatePicker로 날짜 이동 Button
    @State var showDatePicker = false
    
    // 화살표 버튼 클릭 시 달력의 월 이동
    @State var currentMonth: Int = 0
    
    // 다가오는 기념일에 쓰일 변수
    @State var upcomingEventDate: Date = Date()
    @State var upcomingEventBaseDate: Date = Date()
    @State private var upcomingEventTitle: String = ""
    @State private var upcomingEventMemo: String = ""
    
    // 달력 스와이프에 필요한 변수
    @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none
    @Environment(\.dismiss) private var dismiss
    //Upcoming Events 추가
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    //    @ObservedObject private var calendarViewModel: CalendarViewModel = CalendarViewModel()
    //    @State private var isLoaded = false
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)
    
    @State private var isLoaded = false
    private var daysHeader: some View {
        HStack(spacing: 0) {
            ForEach(CalendarDay.allCases, id: \.self) {day in
                Text(day.rawValue)
                    .font(.callout)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    private var moveMonthConroller: some View {
        HStack(spacing: 80) {
            // MARK: - 달력 이전 달로 이동
            Button {
                isLoaded = false
                withAnimation { self.currentDate = self.moveCurrentMonth(isUp: false) }
                fetchList(month: self.currentDate) {
                     isLoaded = true
                }
            } label: {
                Text(monthDate(currentDate: self.currentDate.getPreviousMonth() ?? currentDate)[0])
                    .font(.TextStyles.mediumCalendarNumber).opacity(0.3)
                    .foregroundColor(.burgundy)
            }
            .padding(.top, 30)
            .padding(.trailing, 30)
            
            VStack(spacing: -6) {
                // MARK: - 달력의 년+월
                Text(fullDate(currentDate: self.currentDate)[0])
                    .font(.TextStyles.smallCalendarNumber)
                    .foregroundColor(.burgundy)
                
                Text(fullDate(currentDate: self.currentDate)[1])
                    .font(.TextStyles.largeCalendarNumber)
                    .foregroundColor(.burgundy)
                    .padding(.top, -10)
                    .padding(.bottom, -10)
            }
            // MARK: - 달력 다음 달로 이동
            Button {
                isLoaded = false
                withAnimation { self.currentDate = self.moveCurrentMonth(isUp: true) }
                fetchList(month: self.currentDate) {
                   isLoaded = true
                }
            } label: {
                Text(monthDate(currentDate: self.currentDate.getNextMonth() ?? currentDate)[0]).opacity(0.3)
                    .font(.TextStyles.mediumCalendarNumber)
                    .foregroundColor(.burgundy)
            }
            .padding(.top, 30)
            .padding(.leading, 30)
        }
    }
    func fetchList(month: Date, completion: @escaping ()->()) {
        Task {
            await CalendarViewModel.viewModel.calendarMainGet(month: month.toServerFormatString()) {
                completion()
            }
        }
    }
    func checkEventDate(date: Date) -> Bool {
        for event in CalendarViewModel.viewModel.calendarList.eventResponseList {
            if event.upcomingEventDate == date.toServerFormatString() {
                return true
            }
        }
        return false
    }
    
    func checkGiftType(date: Date) -> String? {
        for gift in CalendarViewModel.viewModel.calendarList.monthResponses {
            if gift.createdAt == date.toServerFormatString() {
                return gift.giftType
            }
        }
        return nil
    }
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
//                if isLoaded {
                    // MARK: 상단 달 이동 버튼
                    moveMonthConroller
                    // MARK: 요일 표시(월~일) 헤더
                    daysHeader
                    // MARK: 날짜 격자
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(extractDate(currentDate: self.currentDate)) { calendarData in
                            NavigationLink(destination: CalendarGiftBox(date: calendarData.date)) {
                                CardView(value: calendarData,
                                         hadEvent: checkEventDate(date: calendarData.date),
                                         giftType: checkGiftType(date: calendarData.date))
                            }
                        }
                    }
                     .gesture(swipe)
                    
                    // MARK: - Upcoming Events
                    VStack(spacing: 0) {
                        HStack {
                            Text("이달의 기념일")
                                .font(.title3.bold())
                                .foregroundColor(.burgundy)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, -10)
                                .padding(.leading, 2)
                            
                            Spacer(minLength: 0)
                            //이벤트 추가 버튼
                            Button(action: {
                                showSheet = true
                                upcomingEventTitle = ""
                                upcomingEventMemo = ""
                                isLoaded = false
                            }) {
                                Image(systemName: "plus")
                                    .font(.title3)
                                    .foregroundColor(.burgundy)
                                    .sheet(isPresented: $showSheet, content: {
                                        AddUpcomingEventView(
                                            isLoaded: self.$isLoaded,
                                            upcomingEventDate: self.$currentDate,
                                            upcomingEventBaseDate: self.$currentDate)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    })
                            }
                        }
                        .padding(.vertical)
                        // 이벤트 나열
                        ScrollView(.vertical, showsIndicators: false) {
                            if isLoaded {
                            if let events = CalendarViewModel.viewModel.calendarList.eventResponseList {
                                if !events.isEmpty {
                                    let sortEvents = events.sorted(by: { $0.upcomingEventDate < $1.upcomingEventDate})

                                    VStack(spacing: 0) {
                                        ForEach(sortEvents) { upcoming in
                                            UpcomingEventsView(event: upcoming)
                                            Divider()
                                        }
                                    }
                                } else { noEvent }
                            }
                        }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .background(Color.backgroundGray)
            }
            // MARK: - PopupDate와 CalendarView 사이에 블러 효과
            .opacity(isClicked ? 0.1 : 1 )
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationToBack(dismiss)
            .navigationBarTitleDisplayMode(.inline)
        }
        // MARK: - 데이터 가져오는 부분
        .task {
            await CalendarViewModel.viewModel.calendarMainGet(month: currentDate.toServerFormatString()) {
                isLoaded = true
            }
        }

//        .toolbar {
            // MARK: - 메인 달력 날짜 고르는 PopupDate Button
//            Button {
//               showDatePicker.toggle()
//                isClicked.toggle()
//            } label: {
//                Image(systemName: "calendar")
//                    .foregroundColor(.burgundy)
//                    .font(.body)
//            }
//        }

        // MARK: - PopUpView
//        if showDatePicker {
//            PopupDate(popupDate: self.currentDate,
//                      currentDate: $currentDate,
//                      showDatePicker: $showDatePicker,
//                      popUpBoolean: $showDatePicker,
//                      isClicked: $isClicked)
//        }
        
    }
    
    // MARK: - 기념일이 없는 경우
    var noEvent: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.backgroundGray)
                    .frame(width: 360, height: 65)
                
                HStack {
                    Text("기억하고 싶은 기념일을 추가해보세요!")
                        .font(.body.bold())
                        .foregroundColor(.textBodyColor)
                }
            }
        }
    }
    
    @State private var isStarted: Bool = false
    
    // MARK: - Calendar Swipe Gesture
    private var swipe: some Gesture {
        DragGesture(minimumDistance: 1)
            .onChanged{ value in
                if !isLoaded {
                    self.isLoaded = true
                }
            }
            .onEnded {
                self.isLoaded = false
                if $0.startLocation.x > $0.location.x {
                    self.swipeHorizontalDirection = .left
                    self.currentDate = self.moveCurrentMonth(isUp: true)
                } else if $0.startLocation.x == $0.location.x {
                    self.swipeHorizontalDirection = .none
                } else {
                    self.swipeHorizontalDirection = .right
                    self.currentDate = self.moveCurrentMonth(isUp: false)
                }
                fetchList(month: self.currentDate) {
                    self.isLoaded = true
                }
            }
    }
    
    enum SwipeHorizontalDirection: String {
        case left, right, none
    }
    
    // MARK: - Calendar에 쓰일 날짜
    enum CalendarDay: String, CaseIterable {
        case Sun = "Sun"
        case Mon = "Mon"
        case Tue = "Tue"
        case Wed = "Wed"
        case Thu = "Thu"
        case Fri = "Fri"
        case Sat = "Sat"
    }
    
    func moveCurrentMonth(isUp: Bool) -> Date {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: (isUp ? 1 : -1), to: self.currentDate)
        else {
            return Date()
        }
        
        return currentMonth
    }
    
    func getCurrentMonth() -> Date {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else {
            return Date()
        }
        
        return currentMonth
    }
    
    func getPreviousMonth() -> Date {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth - 1, to: Date())
        else {
            return Date()
        }
        
        return currentMonth
    }
    
    func getNextMonth() -> Date {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth + 1, to: Date())
        else {
            return Date()
        }
        
        return currentMonth
    }
}

struct CalendarMain_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CalendarView().environmentObject(CalendarViewModel())
                .navigationBarHidden(true)
        }
    }
}

