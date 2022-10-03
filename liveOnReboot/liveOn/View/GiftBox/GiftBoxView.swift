//
//  GiftBoxView.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/09.
//

import SwiftUI

struct GiftBoxView: View {
    @State private var gotoMain = false
    @State private var showAlert = false
    @State private var isLoaded = false
    @State private var isMatched = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack (alignment: .center, spacing: 12) {
                // MARK: 상단 바
                // 커플 정보 라벨과 선물 제작 버튼
                HStack {
                    if isMatched {
                        NavigationLink(destination: CoupleInformationView()) {
                            CoupleInfoLabel(isLoaded: $isLoaded)
                        }
                    } else {
                        NavigationLink(destination: InviteCodeView()) {
                            notMatchedLabel
                        }
                    }
                    Spacer()
                    Button{
                        if GiftManager.isExists {
                            showAlert = true
                        } else {
                            gotoMain = true
                        }
                    } label: {
                        Image("addButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34, alignment: .center)
                    }
                    .alert("선물 일일한도 초과", isPresented: $showAlert) {
                        Button("확인", role: .cancel) {  }
                    } message: {
                        Text("선물은 하루에 한번만 보낼 수 있어요😭")
                    }
                    NavigationLink("",destination: GiftListView(gotoMain: $gotoMain), isActive: $gotoMain)
                }
                .padding(.bottom, 24)
                
                // 달력 버튼
                CalendarLinkView()
                
                // MARK: 보관함 이동 버튼 모음
                VStack(alignment: .center) {
                    // 쪽지, 사진, 음성 메시지, 꽃 보관함 이동 버튼
                    LetterAndPictureLinkView()
                        .padding(.bottom, 12)
                    VoiceAndFlowerLinkView()
                    
                    Spacer()
                } // VStack
            } // VStack
            .padding(.horizontal)
            .foregroundColor(.textBodyColor)
        } // HStack
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .task {
            GiftManager.singleton.isGiftExists()
            MemberConfigService.fetchMemberProfile {
                self.isLoaded = true
            }
            MemberConfigService.validateCoupleMatching {
                self.isMatched = true
            }
               
        }
        .onDisappear{
            self.isLoaded = false
        }
    } // body
    
    var notMatchedLabel : some View {
        VStack(spacing: 0) {
            Text("상대를 기다리는 중...")
                .font(.TextStyles.handWrittenCaption)
            Text("초대코드 보내기")
                .bold()
                .foregroundColor(.coralPink)
                .font(.TextStyles.handWrittenBody)
                .offset(y: -2)
        }
        .padding()
        .frame(height: UIScreen.main.bounds.width * 0.16)
        .frame(minWidth: UIScreen.main.bounds.width * 0.5)
        .background(RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 1)
            .padding(8)
            .foregroundColor(Color.teal)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.thinMaterial)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 4)))
    }
    
}

private struct CoupleInfoLabel: View {
    @Binding var isLoaded : Bool
    var body: some View {
        if isLoaded {
            HStack {
                // TODO: "재헌" -> 상대방 유저의 이름이 들어가게 바꿀 것
                Text(MemberConfigService.singleton.profile.currentUserName)
                Image("heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 22, alignment: .center)
                    .offset(y: 2)
                
                // TODO: "유진" -> 유저의 이름이 들어가게 바꿀 것
                Text(MemberConfigService.singleton.profile.partnerName)
                
                // TODO: "365" -> 설정된 첫 날 부터 앱이 실행되고 있는 시점까지의 날짜 계산해서 넣기
                let date = Date().stringDateToDateFormat(MemberConfigService.singleton.profile.officialDate)
                Text("D+\(String(date.countDays()))")
                    .foregroundColor(.coralPink)
                    .padding(.horizontal,4)
                
            } // HStack
            .padding()
            .frame(height: UIScreen.main.bounds.width * 0.16)
            .background(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .padding(8)
                .foregroundColor(Color.teal)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(.thinMaterial)
                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 4)))
            .font(.TextStyles.handWrittenBody)
            .offset(y: -2)
        }
        else {
            ProgressView()
            .padding()
            .frame(height: UIScreen.main.bounds.width * 0.16)
            .frame(minWidth: UIScreen.main.bounds.width * 0.5)
            .background(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .padding(8)
                .foregroundColor(Color.teal)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(.thinMaterial)
                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 4)))
        }
    } // body
    
    
}

private struct CalendarLinkView: View {
    var body: some View {
        
        NavigationLink(destination: CalendarView()) {
            
            ZStack {
                Image("calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    
                    // TODO: 앱이 실행되는 시점의 달을 영어로 표시
                    Text(Date().monthEnglishToString(Date.now))
                        .font(.TextStyles.smallCalendarNumber)
                        .offset(y: 12)
                    
                    // TODO: 앱이 실행되는 시점의 달을 숫자로 표시
                    Text(Date().monthToString(Date.now))
                        .font(.TextStyles.largeCalendarNumber)
                    
                }
                .foregroundColor(.textBodyColor)
                .offset(x: -106)
                
            } // ZStack
        } // NavigationLink
    } // body
}

private struct LetterAndPictureLinkView: View {
    var body: some View {
        
        HStack {
            
            NavigationLink(destination: LetterListView()) {
                Image("letter")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: -8, y: 12)
            }
            
            NavigationLink(destination: PictureListView()) {
                Image("photocard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
        } // HStack
    } // body
}

private struct VoiceAndFlowerLinkView: View {
    var body: some View {
        
        HStack {
            
            NavigationLink(destination: VoiceMailView()) {
                Image("cassette")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            NavigationLink(destination: FlowerListView().environmentObject(FlowerViewModel())) {
                Image("flower")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        } // HStack
    } // body
}
