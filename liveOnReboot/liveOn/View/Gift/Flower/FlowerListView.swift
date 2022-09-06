//
//  FlowerView.swift
//  liveOnReboot
//
//  Created by teethemoji on 2022/07/17.
//

import SwiftUI

struct FlowerListView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: FlowerViewModel
    @State private var showFlowerPopUp = false
    @State private var isLoaded = false
    @State private var selectedCardIndex = 0
    
    private let columns : [GridItem] = [
        GridItem(.flexible(), spacing: -10, alignment: .bottom),
        GridItem(.flexible(), spacing: 20, alignment: .top)
    ]
    
    var body: some View {

        ZStack {
            VStack {
                Spacer()

                Text("꽃을 눌러 상세 정보를 확인할 수 있어요")
                    .foregroundColor(.textBodyColor)
                Spacer()

                setFlowerBackGroundUI()

                Text("이전에 받은 꽃은\n달력에서 확인할 수 있어요.")
                    .foregroundColor(Color(uiColor: .systemGray2))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
            }

            if showFlowerPopUp {
                FlowerPopUpView(popUpBoolean: $showFlowerPopUp, cardIndex: $selectedCardIndex)
                    .background(.ultraThinMaterial)
                    .onTapGesture {
                        withAnimation {
                            showFlowerPopUp.toggle()
                        }
                    }
            }
        }
        .task {
            viewModel.flowerListGet(completion: {
                isLoaded = true
            })
        }

        .navigationToBack(dismiss)
        .navigationTitle("꽃")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.background)
    } // body

    // UI Functions
    private func setFlowerBackGroundUI() -> some View {
        ZStack(alignment: .center) {
            Image("backgroundForVase")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: Color.shadowColor, radius: 2, x: 0, y: 0)
                .padding(24)

            Circle().fill(.white).frame(width: 160,
                                        height: 160,
                                        alignment: .center)

            Circle()
                .fill(.regularMaterial)
                .padding()
                .overlay(
                    Circle().fill(.gray).frame(width: 100,
                                               height: 100,
                                               alignment: .center).opacity(0.9)
                )

            LazyVGrid(columns: columns, spacing: -40) {
                ForEach(0..<flowerList.count, id: \.self) { index in
                    // TODO: Server
                    FlowerPopUp(content: flowerList[index])
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.5)) {
                                showFlowerPopUp = true
                                selectedCardIndex = index
                            }
                        }
                }
            }
            .padding()
        }
    }
}

struct FlowerListView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerListView().environmentObject(FlowerViewModel())

    }
}
