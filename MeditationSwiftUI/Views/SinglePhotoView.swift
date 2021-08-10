//
//  SinglePhotoView.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 10.02.2021.
//

import SwiftUI
import RealmSwift

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
                    
                    let realm = try! Realm()
                    try! realm.write {
                        let selectPhoto = realm.objects(PhotoModelObject.self).filter("photoName == %@", photo)
                        realm.delete(selectPhoto)
                        
                    }
                    showSinglePhoto.toggle()
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
                    if value.translation.width > CGFloat(UIScreen.main.bounds.width/2) {
                        self.showSinglePhoto.toggle()
                    } else {
                        do {
                            let realm = try Realm()
                            try realm.write {
                                let selectPhoto = realm.objects(PhotoModelObject.self).filter("photoName == %@", photo)
                                realm.delete(selectPhoto)
                            }
                            showSinglePhoto.toggle()
                        } catch {
                            print("error")
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
