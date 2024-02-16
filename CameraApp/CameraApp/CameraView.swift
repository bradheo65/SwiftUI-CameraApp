//
//  CameraView.swift
//  CameraApp
//
//  Created by brad on 2/15/24.
//

import Foundation
import UIKit
import SwiftUI
import UniformTypeIdentifiers

struct CameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    @Binding var image: UIImage?
    @Binding var videoURL: URL?
    @Binding var isShown: Bool
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.delegate = context.coordinator
        
        viewController.sourceType = .camera
        viewController.mediaTypes = [UTType.image.identifier, UTType.movie.identifier]

        viewController.cameraCaptureMode = .photo

        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self, image: $image, videoURL: $videoURL, isShown: $isShown)
    }
}

extension CameraView {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView
        
        @Binding var image: UIImage?
        @Binding var videoURL: URL?
        @Binding var isShown: Bool
        
        init(
            _ parent: CameraView,
            image: Binding<UIImage?>,
            videoURL: Binding<URL?>,
            isShown: Binding<Bool>
        ) {
            self.parent = parent
            self._image = image
            self._videoURL = videoURL
            self._isShown = isShown
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("Cancel pressed")
            isShown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
            switch mediaType {
            case UTType.image.identifier:
                let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

                self.image = image
                isShown.toggle()
                
            case UTType.movie.identifier:
                let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
                self.videoURL = videoUrl
                
                isShown.toggle()
            default:
                print(("Mismatched type: \(mediaType)"))
            }
        }
    }
}
