//
//  ImagePickerView.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 10.02.2021.
//

import Foundation
import SwiftUI
import UIKit
import RealmSwift

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
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.short
            let time = dateFormatter.string(from: Date())
            let photoObject = PhotoModelObject()
            photoObject.time = time
            photoObject.photoName = nameImage
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(photoObject, update: .modified)
                }
            } catch {
                print("error")
            }
            Helper().saveImageToDocumentDirectory(image: image, name: nameImage)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
