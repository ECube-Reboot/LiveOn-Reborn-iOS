//
//  photoCardsView.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/07/16.
//
import SwiftUI
struct PictureListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: PictureViewModel = PictureViewModel()
    @State private var photoIndexPath: Int64 = 0
    @State private var isTapped: Bool = false
    @State private var detailedImage: PictureGetResponse = PictureListView.defaultImageData()
    private let columns = Array(repeating: GridItem(.fixed(180), spacing: 5),count: 2)
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.loadedImageList.reversed(), id: \.giftPolaroidId) { data in
                        Button {
                            isTapped.toggle()
                            photoIndexPath = data.giftPolaroidId
                            detailedImage = viewModel.loadedImageList.first(where: {
                                $0.giftPolaroidId == photoIndexPath}) ?? PictureListView.defaultImageData()
                        }
                    label: {
                        PhotoCard(indexPath: data.giftPolaroidId, imageURLString: data.giftPolaroidImage, comment: "test", isTapped: $isTapped)
                    }
                    }
                    .opacity(isTapped ? 0.2 : 1)
                }
                .navigationTitle("사진")
                .navigationBarTitleDisplayMode(.inline)
                .navigationToBack(dismiss)
                .task {
                    viewModel.imageListGet()
                }
            } // ScrollView
            .padding()
            .blur(radius: isTapped ? 6 : 0)
            .background(Color.lightgray)
            //            .padding(.leading, 10)
        } // Zstack
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
}

struct PhotoCard: View {
    
    var indexPath: Int64
    var imageURLString: String
    var comment: String
    @Binding var isTapped : Bool
    
    var body: some View {
        
        GeometryReader { proxy in
            VStack {
                VStack {
                    AsyncImage(url: URL(string: imageURLString)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width * 0.85, height: proxy.size.width, alignment: .center)
                            .clipped()
                            .border(Color.gray, width: 0.45)
                        
                    } placeholder: {
                        ProgressView()
                            .frame(width: proxy.size.width * 0.85, height: proxy.size.width, alignment: .center)
                        
                            .progressViewStyle(.circular)
                    }
                }
                .foregroundColor(.textBodyColor)
                .padding(12)
                
                Text(comment)
            }
            .padding(.bottom, 12)
            .background(RoundedRectangle(cornerRadius: 6).fill(.white).border(Color.lightgray, width: 1.0).shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 0))
        }
        .frame(height: 250)
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
                .foregroundColor(.textBodyColor)
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
