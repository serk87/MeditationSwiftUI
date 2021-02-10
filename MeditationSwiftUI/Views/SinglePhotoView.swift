//
//  SinglePhotoView.swift
//  MeditationSwiftUI
//
//  Created by Администратор on 10.02.2021.
//

import SwiftUI

struct SinglePhotoView: View {
    
    @Binding var photo : String
    @Binding var showSinglePhoto : Bool
    
    @State var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            VStack {
                Image(uiImage: Helper().loadImageFromDocumentDirectory(nameOfImage: photo))
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(scale)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    
                    .onTapGesture(count: 2) {
                        if scale == 1.0 {
                            scale = 2.0
                        } else {
                            scale = 1.0
                        }
                    }
            }
            .padding(.bottom, 30)
            HStack {
                Button(action: {
                    let defaults = UserDefaults.standard
                    if let photoArray = defaults.array(forKey: "photo") {
                        
                        let mutatingPhoto = photoArray.filter{ $0 as! String != photo } as! [String]
                        
                        defaults.setValue(mutatingPhoto, forKey: "photo")
                        showSinglePhoto.toggle()
                    }
                }, label: {
                    Text("Удалить")
                        .foregroundColor(.white)
                })
                Spacer()
                Button(action: {
                    self.showSinglePhoto.toggle()
                }, label: {
                    Text("Закрыть")
                        .foregroundColor(.white)
                })
            }.padding()
        }.gesture(
            DragGesture(minimumDistance: UIScreen.main.bounds.width/2)
                .onEnded({ (value) in
                    if value.translation.width < CGFloat(UIScreen.main.bounds.width/2) {
                        self.showSinglePhoto.toggle()
                    } else {
                        let defaults = UserDefaults.standard
                        if let photoArray = defaults.array(forKey: "photo") {
                            
                            var mutatingPhoto = photoArray.filter{ $0 as! String != photo } as! [String]
                            
                            defaults.setValue(mutatingPhoto, forKey: "photo")
                            showSinglePhoto.toggle()
                        }
                    }
                })
        )
    }
}

struct SinglePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePhotoView(photo: .constant("avatar"), showSinglePhoto: .constant(true))
    }
}
