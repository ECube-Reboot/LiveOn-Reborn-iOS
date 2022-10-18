//
//  LetterView.swift
//  liveOnReboot
//
//  Created by Jineee on 2022/07/09.
//

import SwiftUI


struct SendLetterView: View {
    @Binding var gotoMain: Bool
    @State private var isSent = false
    @Environment(\.dismiss) var dismiss
    
    @State var showAlertforSend: Bool = false
    @State var letterColor: String = ""
    @State var input: String?
    @State var isValidate = false
    @State var showLoading = false

    private let placeHolder = PlaceHolder.createLetter

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                TextEditor(text: Binding($input, replacingNilWith: ""))
                    .font(.TextStyles.handWrittenBody)
                    .foregroundColor(.textBodyColor)
                if let input = input {
                    let limit = textLimit.letterGift
                    Text("\(input.count )/\(textLimit.letterGift)")
                        .letterCountStyle()
                        .onReceive(input.publisher.collect()) { _ in
                            if input.count > limit {
                                withAnimation() {
                                    self.input = String(input.prefix(limit))
                                }
                            }
                            isValidate = true
                        }
                } else {
                    Text("0/\(textLimit.letterGift)")
                        .letterCountStyle()
                        .onAppear {
                            isValidate = false
                        }
                }
            }
            // MARK: 쪽지 크기&배경 설정
            .frame(maxWidth: UIScreen.main.bounds.width*0.8, maxHeight: UIScreen.main.bounds.width*0.7)
            .padding(24)
            .background(Image(letterColor).resizable().shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 1, y: 3))
            .overlay {
                Text(input ?? placeHolder)
                    .font(.TextStyles.handWrittenBody)
                    .padding(24)
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
                    .foregroundColor(.textBodyColor)
                    .opacity(input == nil ? 0.6 : 0)
            }
            .navigationBarItems(
                trailing: Button {
                    showAlertforSend = true
                } label: {
                    Text("선물하기")
                        .fontWeight(.bold)
                }
                .disabled(!isValidate)
                // MARK: 보내기 전 alert창
                    .alert(isPresented: $showAlertforSend) {
                        Alert(title: Text("선물하기"), message: Text("선물은 하루에 하나만 보낼 수 있어요. 쪽지를 보낼까요?"), primaryButton: .cancel(Text("취소")), secondaryButton: Alert.Button.default(Text("보내기")) {
                            self.showLoading = true
                            LetterViewModel.viewModel.updateContent(color: letterColor, content: input!, posting: LetterViewModel.viewModel.letterPost){
                                self.showLoading = false
//                                self.gotoMain = false
                                self.isSent = true
                            }
                        })
                    })
            .overlay{
              if showLoading {
                Text("로딩뷰")
                  //TODO: 로딩뷰 삽입하기
              }
            }
            .navigationToBack(dismiss)
            .preferredColorScheme(.light)
            .navigationBarTitle("쪽지", displayMode: .inline)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)

            NavigationLink("", destination: GiftDeliveryView(gotoMain: $gotoMain), isActive: $isSent)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
        .background(Color.backgroundGray)
        .onAppear{
            UITextView.appearance().backgroundColor = .clear
            getRandomColor()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func getRandomColor() {
        if let randomColor = LetterColorStyle.letterColors.randomElement() {
            letterColor = randomColor
        }
    }
}
