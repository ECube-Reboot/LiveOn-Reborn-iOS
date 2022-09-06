//
//  SendFlowerView.swift
//  liveOnReboot
//
//  Created by Jisu Jang 2022/09/01
//

import SwiftUI

struct SendFlowerView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: FlowerViewModel = FlowerViewModel()
    @State private var showAlertforSend: Bool = false
    @State private var isValidate = false
    @State private var input: String?
    @State private var showLoading = false
    @State private var isSent = false
    @Binding var gotoMain: Bool
    private let flowerName = getRandomFlower()
    private let placeHolder = "한 줄 편지를 써보세요!"

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                setFlowerChoiceText()
                setFlowerImage()
                setLetter()
                NavigationLink("", destination: GiftDeliveryView(gotoMain: $gotoMain), isActive: $isSent)
            }//body
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationToBack(dismiss)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAlertforSend.toggle()
                } label: {
                    Text("선물하기")
                }
                .disabled(!isValidate)
                .alert(isPresented: $showAlertforSend) {
                    Alert(title: Text("선물하기"), message: Text("선물은 하루에 하나만 보낼 수 있어요. 쪽지를 보낼까요?"), primaryButton: .cancel(Text("취소")), secondaryButton: Alert.Button.default(Text("보내기")) {
                        showLoading.toggle()
                        viewModel.flowerPost(flowerName: flowerName, message: input ?? ""){
                            print("전송완료!")
                            isSent.toggle()
                        }
                    })
                }
            }
            ToolbarItem(placement: .principal) {
                Text("꽃")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
        }
    }

    private func setFlowerChoiceText() -> some View {
        VStack {
            Text(self.flowerName)
            Text(getFlowerPhrase(flowerName: flowerName))
        }
    }

    private func setFlowerImage() -> some View {
        let image = Image(flowerName)
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
        return image
    }

    private func setLetter() -> some View {
        VStack(alignment: .center) {
            TextEditor(text: Binding($input, replacingNilWith: ""))
                .padding()
                .font(.TextStyles.handWrittenBody)
                .foregroundColor(.textBodyColor)
            if let input = input {
                let limit = textLimit.flowerComment
                Text("\(input.count )/\(textLimit.flowerComment)")
                    .letterCountStyle()
                    .padding()
                    .onReceive(input.publisher.collect()) { _ in
                        if input.count > limit {
                            withAnimation() {
                                self.input = String(input.prefix(limit))
                            }
                        }
                        isValidate = true
                    }
            } else {
                Text("0/\(textLimit.flowerComment)")
                    .letterCountStyle()
                    .onAppear {
                        isValidate = false
                    }
            }
        }
        // MARK: 쪽지 크기&배경 설정
        .frame(maxWidth: UIScreen.main.bounds.width*0.8, maxHeight: UIScreen.main.bounds.height*0.2)
        .padding(24)
        .background(Image("letterBackGround").resizable().shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 1, y: 3))
        .overlay {
            Text(input ?? placeHolder)
                .font(.TextStyles.handWrittenBody)
                .padding(40)
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
                .foregroundColor(.textBodyColor)
                .opacity(input == nil ? 0.6 : 0)
        }
    }
}

struct SendFlowerView_Previews: PreviewProvider {
    static var previews: some View {
        SendFlowerView(gotoMain: .constant(false))
    }
}
