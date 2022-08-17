//
//  SendPictureView.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/10.
//
import SwiftUI

struct SendPictureView: View {
    @StateObject var pictureModel = PictureViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var comment: String = ""
    @State private var showAlertforSend: Bool = false
    @State private var isSent = false
    @State private var showLoading = false
    @State private var loadingState: Int = 0

    @Binding var gotoMain: Bool
    var commentLimit: Int = 20

    var body: some View {
        ZStack {
            ScrollView {
                ZStack {
                    VStack(spacing: 15) {
                        Button {
                            pictureModel.source = .library
                            pictureModel.showPhotoPicker()
                        } label: {
                            if let image = pictureModel.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                            } else {
                                Text("사진을 선택해주세요!")
                                    .frame(width: 300, height: 400, alignment: .center)
                                    .background(Color.lightgray)
                                    .cornerRadius(2)
                            }
                        }
                        TextField("Comment", text: $comment, prompt: Text("한 줄 편지를 써주세요!"))
                            .frame(width: 300, height: 20, alignment: .leading)

                        HStack {
                            Text("\(comment.count)/\(textLimit.polaroidComment)")
                                .letterCountStyle()
                                .frame(width: 300, height: 20, alignment: .trailing)
                                .onReceive(comment.publisher.collect()) { _ in
                                    if comment.count >= 20 {
                                        withAnimation() {
                                            self.comment = String(comment.prefix(textLimit.polaroidComment))
                                        }
                                    }
                                }
                        }

                        NavigationLink("", destination: GiftDeliveryView(gotoMain: $gotoMain), isActive: $isSent)
                    }
                    .padding()
                    .background(Color.white
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
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
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .preferredColorScheme(.light)
                            }
                            .alert(isPresented: $showAlertforSend) {
                                Alert(title: Text("선물하기"), message: Text("선물은 하루에 하나만 보낼 수 있어요. 쪽지를 보낼까요?"), primaryButton: .cancel(Text("취소")), secondaryButton: Alert.Button.default(Text("보내기")) {
                                    showLoading.toggle()
                                    imagePost()
                                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                                        loadingState += 1
                                        isSent.toggle()
                                    }
                                })
                            }
                        }
                        ToolbarItem(placement: .principal) {
                            Text("폴라로이드")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    .sheet(isPresented: $pictureModel.showPicker) {
                        PicturePicker(sourceType: pictureModel.source == .library ? .photoLibrary : .camera, selectedImage: $pictureModel.image)
                            .ignoresSafeArea()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.background)
                    .blur(radius: showLoading ? 6 : 0)
                }
                .padding()
                .padding(.top, 80)
                .onTapGesture {
                    hideKeyboard()
                }
            }
            if showLoading == true {
                Image(loadingState == 0 ? "LoadingCharacter" : "")
                    .frame(width: 300, height: 300, alignment: .center)
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.background)
    }

    private func imagePost() {
        moyaService.request(.imagePost(comment: comment, polaroid: pictureModel.image ?? UIImage())) { response in
            switch response {
            case .success(let result):
                print("response는 다음과 같습니다. \(result)")
            case .failure(let err):
                print(err.localizedDescription)
                print("========= 통신 자체가 실패했습니다. ========")
            }
        }
    }
}
