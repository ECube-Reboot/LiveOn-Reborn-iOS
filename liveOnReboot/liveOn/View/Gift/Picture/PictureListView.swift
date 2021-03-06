//
//  photoCardsView.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/07/16.
//
import SwiftUI
struct PictureListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var photoIndexPath: Int64 = 0
    @State private var isTapped: Bool = false
    @State private var loadedImageList: [PictureGetResponse] = []
    @State private var detailedImage: PictureGetResponse = PictureListView.defaultImageData()
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(loadedImageList, id: \.giftPolaroidId) { data in
                        Button(action: {
                            isTapped.toggle()
                            print("This is Button Print")
                            photoIndexPath = data.giftPolaroidId
                            detailedImage = loadedImageList.first(where: {
                                $0.giftPolaroidId == photoIndexPath}) ?? PictureListView.defaultImageData()
                        }) {
                            PhotoCard(indexPath: data.giftPolaroidId, imageURLString: data.giftPolaroidImage, isTapped: $isTapped)
                        }
                    }
                    .opacity(isTapped ? 0.2 : 1)
                }
                .navigationTitle("사진")
                .navigationBarTitleDisplayMode(.inline)
                .navigationToBack(dismiss)
                .task {
                    imageListGet()
                }
            } // ScrollView
            .padding()
            .blur(radius: isTapped ? 6 : 0)
        } // Zstack
        .background(Color.background)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea( edges: .bottom)
        .overlay {
            if isTapped == true {
                PhotoCardSheet(indexPath: detailedImage.giftPolaroidId, imageURLString: detailedImage.giftPolaroidImage)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            isTapped.toggle()
                        }
                    }
            }
        }
    }
    
    private func imageListGet() {
        moyaService.request(.imageListGet) { response in
            switch response {
            case .success(let result):
                do {
                    print("========= result :  \(result.data) =========")
                    let data = try result.map([PictureGetResponse].self)
                    print("Data : \(data)")
                    mapListData(listData: data)
                    
                } catch let err {
                    print(err.localizedDescription)
                    print("Failed to decode the image list")
                    break
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    private func mapListData(listData: [PictureGetResponse]) {
        for data in listData {
            loadedImageList.append(data)
        }
    }
}
// MARK: PhotoCard
// TODO: 추후에 PictureModel에 넣을 예정
struct PhotoCard: View {
    
    var indexPath: Int64
    var imageURLString: String
    @Binding var isTapped : Bool
    
    var body: some View {
        
        GeometryReader { proxy in
            VStack {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: imageURLString)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width * 0.85, height: proxy.size.width, alignment: .center)
                            .clipped()
                            .border(Color.gray, width: 0.45)

                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                .foregroundColor(.bodyTextColor)
                .padding(12)
            }
            .padding(.bottom, 12)
            .background(RoundedRectangle(cornerRadius: 6).fill(.thickMaterial)  .border(Color.shadowColor, width: 1.0).shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 0))
        }
        .frame(height: 240)
    }
}

struct PhotoCardSheet: View {
    
    var indexPath: Int64
    var imageURLString: String
    var photoText: String = "Temporary Text!"
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: imageURLString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.4, alignment: .center)

            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            Text(photoText)
                .setHandWritten()
                .foregroundColor(.bodyTextColor)
        }
        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.45, alignment: .center)
        .padding(8)
        .padding(.top, 4)
        .padding(.bottom, 12)
        .background(Color.white
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
    }
}

struct VoicemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PictureListView()
        }
    }
}

extension PictureListView {
    static func defaultImageData() -> PictureGetResponse {
        return PictureGetResponse(createdAt: "", giftPolaroidId: 0, giftPolaroidImage: "", userNickName: "")
    }
}
