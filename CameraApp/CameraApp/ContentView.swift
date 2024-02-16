//
//  ContentView.swift
//  CameraApp
//
//  Created by brad on 2/15/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var showCamera: Bool = false
    
    @State private var image: UIImage? = nil
    @State private var videoURL: URL? = nil

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            
            if let videoURL = videoURL {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(width: 150, height: 150)
            }
            
            Button {
                showCamera.toggle()
            } label: {
                Text("카메라")
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraView(
                image: $image,
                videoURL: $videoURL,
                isShown: $showCamera
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
