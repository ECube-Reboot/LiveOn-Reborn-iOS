//
//  CalendarView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/09.
//

import SwiftUI

struct CalendarView: View {
    // 기본 베이스가 되는 날짜 변수
    @State var currentDate: Date = Date()
    
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
    
    // 달력 해당 날짜 눌렀을 때 해당 날짜에 주고 받은 선물을 한 눈에 보는 뷰로 이동할 때 쓰는 변수
//    @State var isNavigationOn: Bool = false
    
    // 달력 스와이프에 필요한 변수
    @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none
    
    //Upcoming Events 추가
    @EnvironmentObject var store: CalendarViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack(spacing: 80) {
                    // 달력 이전 달로 이동
                    Button {
                        withAnimation {
                            self.currentDate = self.moveCurrentMonth(isUp: false)
                        }
                    } label: {
                        Text(monthDate(currentDate: self.currentDate.getPreviousMonth() ?? currentDate)[0])
                            .font(.TextStyles.mediumCalendarNumber).opacity(0.3)
                            .foregroundColor(.burgundy)
                    }
                    .padding(.top, 30)
                    .padding(.trailing, 30)
                    
                    VStack(spacing: -6) {
                        // 달력의 년+월
                        Text(fullDate(currentDate: self.currentDate)[0])
                            .font(.TextStyles.smallCalendarNumber)
                            .foregroundColor(.burgundy)
                        
                        Text(fullDate(currentDate: self.currentDate)[1])
                            .font(.TextStyles.largeCalendarNumber)
                            .foregroundColor(.burgundy)
                            .padding(.top, -10)
                            .padding(.bottom, -10)
                    }
                    // 달력 다음 달로 이동
                    Button {
                        withAnimation {
                            self.currentDate =  self.moveCurrentMonth(isUp: true)
                        }
                    } label: {
                        Text(monthDate(currentDate: self.currentDate.getNextMonth() ?? currentDate)[0]).opacity(0.3)
                            .font(.TextStyles.mediumCalendarNumber)
                            .foregroundColor(.burgundy)
                    }
                    .padding(.top, 30)
                    .padding(.leading, 30)
                }
                // Day View
                HStack(spacing: 0) {
                    ForEach(CalendarDay.allCases, id: \.self) {day in
                        Text(day.rawValue)
                            .font(.callout)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                    }
                }
                // Dates
                // Lazy Grid
                let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)
                
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(extractDate(currentDate: self.currentDate)) { value in
                        ZStack(alignment: .topLeading) {
                            NavigationLink(destination: CalendarGiftBox(date: value.date)) {
                                CardView(value: value, model: store.list.filter{ $0.upcomingEventdate == DateToStringUpcomingEventsViewModel(value.date) })
                            }
//                            CardView(value: value)
//                                .onTapGesture {
//                                    currentDate = value.date
//                                }
                            
//                            NavigationLink (destination: APITEST(), isActive: $isNavigationOn) {
//                                CardView(value: value)
//                                    .onTapGesture {
//                                        isNavigationOn.toggle()
//                                        currentDate = value.date
//                                        PostPracticeFunction(apiTestText: apiTest)
//                                    }
//                            }
                        }
                    }
                }
                .gesture(swipe)
                
                // Upcoming Events
                VStack(spacing: 10) {
                    HStack {
                        Text("Upcoming Events")
                            .font(.title3.bold())
                            .foregroundColor(.burgundy)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, -10)
                            .padding(.leading, 2)
                                                
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            showSheet.toggle()
                            upcomingEventTitle = ""
                            upcomingEventMemo = ""
                        }) {
                            Image(systemName: "plus")
                                .font(.title3)
                                .foregroundColor(.burgundy)
                                .sheet(isPresented: $showSheet, content: {
                                    AddUpcomingEventView(
                                        upcomingEventDate: $upcomingEventDate,
                                        upcomingEventBaseDate: $upcomingEventBaseDate,
                                        upcomingEventTitle: $upcomingEventTitle,
                                        upcomingEventMemo: $upcomingEventMemo)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                })
                        }
                        .padding(.trailing, 6)
                    }
                    .padding([.trailing, .leading])
                    
                    // UpcomingEvents 추가
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            if store.list.count == 0 {
                                noEvent
                            }
                            if store.list.count >= 1 {
                                ForEach(store.list) { upcoming in
                                    UpcomingEventsView(event: upcoming)
                                }
                            }
                        }
                    }
                    .padding([.leading, .trailing, .top])
                }
            }
            // PopupDate와 CalendarView 사이에 블러 효과
            .opacity(isClicked ? 0.1 : 1 )
        }
        .toolbar {
            // 메인 달력 날짜 고르는 PopupDate Button
            Button {
                showDatePicker.toggle()
                isClicked.toggle()
            } label: {
                Image(systemName: "calendar")
                    .foregroundColor(.burgundy)
                    .font(.body)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
        // PopUpView 띄우는 코드
        if showDatePicker {
            PopupDate(popupDate: self.currentDate,
                      currentDate: $currentDate,
                      showDatePicker: $showDatePicker,
                      popUpBoolean: $showDatePicker,
                      isClicked: $isClicked)
        }
    }
    
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
    
    var swipe: some Gesture {
        DragGesture(minimumDistance: 1)
            .onEnded {
                if $0.startLocation.x > $0.location.x {
                    self.swipeHorizontalDirection = .left
                    self.currentDate = self.moveCurrentMonth(isUp: true)
                } else if $0.startLocation.x == $0.location.x {
                    self.swipeHorizontalDirection = .none
                } else {
                    self.swipeHorizontalDirection = .right
                    self.currentDate = self.moveCurrentMonth(isUp: false)
                }
            }
    }
    
    enum CalendarDay: String, CaseIterable {
        case Sun = "Sun"
        case Mon = "Mon"
        case Tue = "Tue"
        case Wed = "Wed"
        case Thu = "Thu"
        case Fri = "Fri"
        case Sat = "Sat"
    }
    
    enum SwipeHorizontalDirection: String {
        case left, right, none
    }
    
    // 문제의 구간 -> 아래 두 함수를 Calendar+Extension 파일에 분리하고 싶은데 어렵네
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

