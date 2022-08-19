//
//  SendPictureView.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/10.
//
import SwiftUI

struct SendPictureView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var pictureModel = PictureViewModel()
    @State private var comment: String = ""
    @State private var showAlertforSend: Bool = false
    @State private var isSent = false
    @State private var showLoading = false
    @State private var loadingState: Int = 0
    @Binding var gotoMain: Bool

    var body: some View {
        ZStack {
            ScrollView {
                ZStack {
                    VStack(spacing: 15) {
                        Button {
                            pictureModel.source = .library
                            pictureModel.showPhotoPicker()
                        } label: {
                            if let selectedImage = pictureModel.image {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                            } else {
                                Text("사진을 선택해주세요!")
                                    .foregroundColor(Color.textBodyColor)
                                    .frame(width: 300, height: 400, alignment: .center)
                                    .background(Color.backgroundGray)
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
                                if pictureModel.image != nil {
                                    showAlertforSend.toggle()
                                }
                            } label: {
                                Text("선물하기")
                            }
                            .disabled(pictureModel.image == nil)
                            .alert(isPresented: $showAlertforSend) {
                                Alert(title: Text("선물하기"), message: Text("선물은 하루에 하나만 보낼 수 있어요. 쪽지를 보낼까요?"), primaryButton: .cancel(Text("취소")), secondaryButton: Alert.Button.default(Text("보내기")) {
                                    showLoading.toggle()

                                    imagePost {
                                        print("전송완료!")
                                        showLoading.toggle()
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
                    .background(Color.backgroundGray)
                }
                .padding()
                .padding(.top, 80)
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .overlay{
                if showLoading {
                    LoadingView()
                }
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.background)
    }

    private func imagePost(completion: @escaping () -> ()) {
        moyaService.request(.imagePost(comment: comment, polaroid: pictureModel.image ?? UIImage())) { response in
            switch response {
            case .success:
                completion()
            case .failure(let err):
                print(err.localizedDescription)
                print("========= 통신 자체가 실패했습니다. ========")
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        Text("선물 보내는 중...")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(.thickMaterial)
    }
}
