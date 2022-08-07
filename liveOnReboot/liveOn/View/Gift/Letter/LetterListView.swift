//
//  LetterView.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/07.
//

import SwiftUI

struct LetterListView: View {
  @ObservedObject private var viewModel: LetterViewModel = LetterViewModel()
  @State var selectedLetter: LetterGet?
  @State var showDetail = false
  @State var showCreateView = false
  var body: some View {
    ZStack {
      ScrollView(.vertical) {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 1, alignment: .center), count: 2)
        
        LazyVGrid(columns: columns, spacing: 1) {
          ForEach(viewModel.letterList,  id: \.giftMemoId) { letter in
            LetterView(letter: letter)
              .onTapGesture {
                selectedLetter = letter
                withAnimation {
                  showDetail.toggle()
                }
              }
          }
        }
      } // ScrollView
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .background(Color.backgroundGray)
    .navigationTitle("쪽지함")
    .toolbar {
    ToolbarItem(placement: .navigationBarTrailing) {
      NavigationLink(destination: SendLetterView(gotoMain: $showCreateView), isActive: $showCreateView) {
        Image("addButton")
          .resizable()
          .frame(width: 24, height: 24, alignment: .center)
          .aspectRatio(contentMode: .fit)
      }
    }
    }
    .navigationBarTitleDisplayMode(.inline)
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
      do  {
        try await viewModel.letterListGet()
      } catch {
        print("error")
      }
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
        .background(Image("letter_green").resizable().scaledToFit().shadow(color: .shadowColor, radius: 2, x: 1, y: 1))
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
      .background(Image("letter_green").resizable().scaledToFit().shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 1, y: 3))
    }
  }
}
