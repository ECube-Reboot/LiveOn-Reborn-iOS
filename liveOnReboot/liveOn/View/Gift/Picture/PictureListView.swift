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
    @State private var isLoaded: Bool = false
    private let columns = Array(repeating: GridItem(.fixed(180), spacing: 5),count: 2)
    
    var body: some View {
        ZStack {
            if !isLoaded {
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
                            PhotoCard(indexPath: data.giftPolaroidId, imageURLString: data.giftPolaroidImage, comment: data.comment, isTapped: $isTapped)
                        }
                        }
                        .opacity(isTapped ? 0.2 : 1)
                    }
                    .navigationTitle("사진")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationToBack(dismiss)
                    .task {
                        viewModel.imageListGet {
                            isLoaded.toggle()
                        }
                    }
                } // ScrollView
                .padding()
                .blur(radius: isTapped ? 6 : 0)
                .background(Color.lightgray)
            } else {
                Text("아직 주고받은 사진이 없어요.")
                    .foregroundColor(.textBodyColor)
                    .opacity(0.5)
            }
        } // Zstack
        .overlay {
            if isTapped == true {
                PhotoCardSheet(indexPath: detailedImage.giftPolaroidId, imageURLString: detailedImage.giftPolaroidImage, photoText: detailedImage.comment)
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

        VStack {
            VStack {
                CacheAsyncImage(
                    url: URL(string: imageURLString)!
                ) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.22, alignment: .center)
                            .clipped()

                    case .failure(let error):
                        Text(error.localizedDescription)
                            .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.2, alignment: .center)

                    case .empty:
                        ProgressView()
                            .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
                    @unknown default:
                        Image(systemName: "questionmark")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
                            .clipped()
                            .border(Color.gray, width: 0.45)
                    }
                }
            }
            .foregroundColor(.textBodyColor)
            .padding(6)

            Text(comment)
                .font(.TextStyles.handWrittenCallout)
                .lineLimit(1)
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
        }
        .padding(.bottom, 12)
        .background(RoundedRectangle(cornerRadius: 6).fill(.white).border(Color.lightgray, width: 1.0).shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 0))
        .frame(height: 250)
    }
}

struct PhotoCardSheet: View {
    
    var indexPath: Int64
    var imageURLString: String
    var photoText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            CacheAsyncImage(
                url: URL(string: imageURLString)!
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.4, alignment: .center)
                        .clipped()
                        .border(Color.gray, width: 0.45)

                case .failure(let error):
                    Text(error.localizedDescription)
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.4, alignment: .center)

                case .empty:
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.4, alignment: .center)
                @unknown default:
                    Image(systemName: "questionmark")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.4, alignment: .center)
                        .clipped()
                        .border(Color.gray, width: 0.45)
                }
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
        return PictureGetResponse(createdAt: "", giftPolaroidId: 0, giftPolaroidImage: "", userNickName: "", comment: "")
    }
}

struct CacheAsyncImage<Content>: View where Content: View {

    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {

        if let cached = ImageCache[url] {
            let _ = print("cached \(url.absoluteString)")
            content(.success(cached))
        } else {
            let _ = print("request \(url.absoluteString)")
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }

        return content(phase)
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}

