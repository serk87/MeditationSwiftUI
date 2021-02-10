//
//  ImagePickerView.swift
//  MeditationSwiftUI
//
//  Created by ladmin on 10.02.2021.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
 
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
            return ImagePickerViewCoordinator(isPresented: $isPresented)
        }
 
    func makeUIViewController(context: Context) -> UIImagePickerController {
           let pickerController = UIImagePickerController()
           pickerController.sourceType = sourceType
           pickerController.delegate = context.coordinator
           return pickerController
       }

       func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
       }
}


class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let nameImage = "\(UUID().uuidString).png"
            let defaults = UserDefaults.standard
            let photoArray = defaults.array(forKey: "photo")
            
            var mutatingPhoto = photoArray as! [String]
            mutatingPhoto.append(nameImage)
            defaults.setValue(mutatingPhoto, forKey: "photo")
            Helper().saveImageToDocumentDirectory(image: image, name: nameImage)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
