//
//  CalendarGiftBox.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/08/24.
//

import SwiftUI

struct CalendarGiftBox: View {
    @State var date: Date
    @State private var isLoaded: Bool = false
    @Environment(\.dismiss) private var dismiss
    private let responseList = CalendarViewModel.viewModel.boxList
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if isLoaded {
                Text(Date().eventDateToString(self.date))
                    .font(.TextStyles.largeCalendarNumber)
                    .foregroundColor(.textBodyColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.vertical, showsIndicators: false) {
                //MARK: EVENT LIST
                    VStack(spacing: 0) {
                        ForEach(CalendarViewModel.viewModel.boxList.eventResponse, id: \.upcomingEventID) { event in
                            let eventShow = EventResponseList(upcomingEventDate: event.upcomingEventDate, upcomingEventId: Int64(event.upcomingEventID), upcomingEventMemo: event.upcomingEventMemo, upcomingEventTitle: event.upcomingEventTitle)
                            UpcomingEventsView(event: eventShow)
                        }
                }
                .padding(.bottom, 24)
                if CalendarViewModel.viewModel.checkGift() {
                    VStack(alignment: .center, spacing: 0) {
                        
                            /// 이벤트 목록 넣기
                            VStack(spacing: 0) {
                                //MARK: PHOTOCARD
                                ForEach(CalendarViewModel.viewModel.boxList.polaroidResponseList, id: \.polaroidID) { polaroid in
                                    PhotoCardSheet(indexPath: Int64(polaroid.giftPolaroidID), imageURLString: polaroid.giftPolaroidImage, photoText: polaroid.comment)
                                }
                                //MARK: NOTE
                                ForEach(CalendarViewModel.viewModel.boxList.noteResponseList, id: \.noteID) { letter in
                                    let temp = LetterGet(color: letter.color, content: letter.content, createdAt: letter.createdAt, giftNoteId: Int64(letter.noteID), userNickName: letter.senderName)
                                    LetterListView.LetterDetailView(letter: temp)
                                }
                                //MARK: AUDIO
                                ForEach(CalendarViewModel.viewModel.boxList.audioResponseList, id: \.voiceMailID){ voiceMail in
                                   //TODO: VoiceMail POPUP VIEW 넣기
                                }
                                //MARK: FLOWER
                                ForEach(CalendarViewModel.viewModel.boxList.flowerResponseList, id: \.senderName){ flower in
                                    //TODO: FLOWERVIEW POPUP VIEW 넣기
                                }
                            }
                        // ScrollView
                        .navigationBarTitleDisplayMode(.inline)
                    }
                } else { noGiftView.opacity(0.6) }
            }
            } else {
                ProgressView()
                    .task {
                        await CalendarViewModel.viewModel.calendarDayGet(month: date.toServerFormatString()) {
                            isLoaded = true
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .navigationToBack(dismiss)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    var noGiftView: some View {
        VStack(alignment: .center, spacing: 12) {
            Image("LoadingCharacter")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: UIScreen.main.bounds.width*0.5)
                
            Text("어떤 선물이 오고 있을까요?")
                .foregroundColor(.textBodyColor)
                .font(.TextStyles.handWrittenBody)
        }
        .frame(maxWidth: .infinity)
    }
}

struct CalendarGiftBox_Previews: PreviewProvider {
    static var previews: some View {
        CalendarGiftBox(date: Date.now)
    }
}
