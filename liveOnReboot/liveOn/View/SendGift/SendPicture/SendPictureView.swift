//
//  SendPictureView.swift
//  liveOnReboot
//
//  Created by Keum MinSeok on 2022/07/10.
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
                                    .cornerRadius(2)
                            }
                        }
                        
                        TextField("Comment", text: $comment, prompt: Text("한 줄 편지를 써주세요!"))
                            .limitInputLength(value: $comment, length: 20)
                            .frame(width: 300, height: 20, alignment: .leading)
                        
                        HStack {
                            Text("\(comment.count)/20")
                                .frame(width: 300, height: 20, alignment: .trailing)
                                .foregroundColor(.textBodyColor).opacity(0.5)
                        }
                        
                        NavigationLink("", destination: GiftDeliveryView(gotoMain: $gotoMain), isActive: $isSent)
                    }
                    .background(
                        Color.white
                        .cornerRadius(5)
                        .shadow(color: Color.lightgray, radius: 4, x: 0, y: 4)
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.backgroundGray)
                    .blur(radius: showLoading ? 6 : 0)
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
                            //

                            Button(action: {
                                showLoading.toggle()
                                imagePost()
                                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                                    loadingState += 1
                                    isSent.toggle()
                                }
                            }) {
                                Text("선물하기")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .preferredColorScheme(.light)
                            }
                            //
                        }
                        ToolbarItem(placement: .principal) {
                            Text("폴라로이드")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    } // toolbar 끝
                    // MARK: ImagePicker에 selectedImage가 binding으로 묶여있어 ImaageViewModel 내의 데이터가 바뀌게 됨
                    .sheet(isPresented: $pictureModel.showPicker) {
                        PicturePicker(sourceType: pictureModel.source == .library ? .photoLibrary : .camera, selectedImage: $pictureModel.image)
                            .ignoresSafeArea()
                    }
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
        .background(Color.backgroundGray)
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
