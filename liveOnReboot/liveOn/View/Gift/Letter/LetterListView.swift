//
//  LetterView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/07.
//

import SwiftUI

struct LetterListView: View {
    @ObservedObject private var viewModel: LetterViewModel = LetterViewModel()
    @State private var selectedLetter: LetterGet?
    @State private var showDetail = false
    @State private var showCreateView = false
    @State private var isLoaded = false
    @State private var showAlert = false
    @Environment(\.dismiss) private var dismiss
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 300),
                                            spacing: 1,
                                            alignment: .center),count: 2)
    var body: some View {
        VStack{
                if !isLoaded {
                    ProgressView()
                } else {
                    if !viewModel.letterList.isEmpty {
                        ScrollView(.vertical) {
                        LazyVGrid(columns: columns, spacing: 1) {
                            ForEach(viewModel.letterList.reversed(),  id: \.giftNoteId) { letter in
                                LetterView(letter: letter)
                                    .onTapGesture {
                                        selectedLetter = letter
                                        withAnimation {
                                            showDetail.toggle()
                                        }
                                    }
                            }
                        }
                        }
                    } else {
                        Text("아직 주고받은 쪽지가 없어요🥲")
                            .foregroundColor(.emptyGiftTextColor)
                    }
                }
            NavigationLink("",destination: SendLetterView(gotoMain: $showCreateView), isActive: $showCreateView)
        }  // ScrollView
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.backgroundGray)
        .navigationTitle("쪽지함")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    if GiftManager.isExists {
                        showAlert = true
                    } else {
                        showCreateView = true
                    }
                } label: {
                    Image("addButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24, alignment: .center)
                }
            }
        }
        .alert("선물 일일한도 초과", isPresented: $showAlert) {
            Button("확인", role: .cancel) {  }
        } message: {
            Text("선물은 하루에 한번만 보낼 수 있어요😭")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationToBack(dismiss)
        .overlay {
            if showDetail {
                if let letter = selectedLetter {
                    LetterDetailView(letter: letter)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .background(.ultraThinMaterial)
                        .onTapGesture {
                            withAnimation {
                                showDetail.toggle()
                            }
                        }
                }
            }
        }
        .task {
            await viewModel.letterListGet(completion: {
                isLoaded = true
            })
        }
    }
}

extension LetterListView {
    
    struct LetterView: View {
        let letter: LetterGet
        
        var body: some View {
            ZStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(letter.content)
                        .font(.TextStyles.handWrittenBody)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
                    
                    Text("from \(letter.userNickName)")
                        .font(.TextStyles.handWrittenCallout)
                        .opacity(0.8)
                        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .trailing)
                    
                }
                .padding(24)
                .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.width*0.45, alignment: .center)
                .foregroundColor(.textBodyColor)
                .background(Image(letter.color).resizable().scaledToFit().shadow(color: .shadowColor, radius: 2, x: 1, y: 1))
            }
        }
    }
    
    struct LetterDetailView: View {
        let letter: LetterGet
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                VStack {
                    Text(letter.content)
                        .font(.TextStyles.handWrittenBody)
                        .lineSpacing(4)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    VStack {
                        Text(Date().stringDateToFormat(letter.createdAt))
                        Text("from.\(letter.userNickName)")
                    }
                    .font(.TextStyles.handWrittenCallout)
                    .padding(.bottom, 4)
                    .opacity(0.8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(width: UIScreen.main.bounds.width*0.65, height: UIScreen.main.bounds.width*0.55, alignment: .leading)
            }
            .foregroundColor(.textBodyColor)
            .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.9, alignment: .center)
            .background(Image(letter.color).resizable().scaledToFit().shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 1, y: 3))
        }
    }
}
