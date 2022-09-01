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
    @State private var letterText = ""
    @State private var showLoading = false
    let flowerName = getRandomFlower()

    var body: some View {
        VStack {
            setFlowerChoiceText()
            setFlowerImage()
            setLetter()
        }//body
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
                .disabled(letterText.isEmpty == true)
                .alert(isPresented: $showAlertforSend) {
                    Alert(title: Text("선물하기"), message: Text("선물은 하루에 하나만 보낼 수 있어요. 쪽지를 보낼까요?"), primaryButton: .cancel(Text("취소")), secondaryButton: Alert.Button.default(Text("보내기")) {
                        showLoading.toggle()

                        viewModel.flowerPost(flowerType: flowerName, message: letterText){
                            print("전송완료!")
                            showLoading.toggle()
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

    private func setFlowerImage() -> Image {
        let image = Image(flowerName)
        return image
    }

    private func setLetter() -> some View {
        TextEditor(text: $letterText)
            .background(Color.lightgray)
            .frame(width: 300, height: 300, alignment: .center)
    }
}

struct SendFlowerView_Previews: PreviewProvider {
    static var previews: some View {
        SendFlowerView()
    }
}
