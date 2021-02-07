//
//  ProfileView.swift
//  MeditationSwiftUI
//
//  Created by Администратор on 07.02.2021.
//

import SwiftUI

struct ProfileView: View {
    @State var showMenu = false
    var body: some View {
        ZStack {
            Color(red: 37/255, green: 51/255, blue: 52/255)
            if showMenu {
                MenuView(showMenu: $showMenu)
            } else {
                ProfileInView(showMenu: $showMenu)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfileInView: View {
    @Binding var showMenu: Bool
    @State private var isShowPhotoLibrary = false
    var columns: [GridItem] =
            Array(repeating: .init(.fixed(170)), count: 2)
    var body: some View {
        VStack(spacing: 10) {
            HStack {
            Image("hamburger")
                .resizable()
                .frame(width: 22, height: 18)
                .onTapGesture {
                    showMenu.toggle()
                }
            Spacer()
            Image("logo")
                .resizable()
                .frame(width: 43.41, height: 49)
            Spacer()
            Image("avatar")
                .resizable()
                .clipShape(Circle())
                .frame(width: 35, height: 35)
        } .padding(.horizontal, 25).padding(.top, 75)
            Image("avatar")
                .resizable()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
            Text("Эмиль")
                .font(.custom("AlegreyaSans-Medium", size: 35))
                .foregroundColor(.white)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach((0...3), id: \.self) { i in
                        ZStack {
                        Image("photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 153, height: 115)
                            Text("11:00")
                                .font(.custom("AlegreyaSans-Medium", size: 18))
                                .foregroundColor(.white)
                                .padding(.trailing, 70)
                                .padding(.top, 50)
                        }.cornerRadius(10)
                    }
                    ZStack {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        
                        Text("11:00")
                            .font(.custom("AlegreyaSans-Medium", size: 18))
                            .foregroundColor(.white)
                            .padding(.trailing, 70)
                            .padding(.top, 50)
                    }
                    .frame(width: 153, height: 115)
                    .background(Color(red: 106/255, green: 174/255, blue: 114/255))
                    .cornerRadius(10)
                    .onTapGesture {
                        isShowPhotoLibrary.toggle()
                    }
                }
            }
        }.sheet(isPresented: $isShowPhotoLibrary, content: {
            ImagePicker()
        })
    }
}



struct ImagePicker: UIViewControllerRepresentable {
 
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
 
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
}
