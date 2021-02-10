//
//  ProfileView.swift
//  MeditationSwiftUI
//
//  Created by Администратор on 07.02.2021.
//

import SwiftUI
import UIKit
import Foundation
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @State var showMenu = false
    @Binding var numberPage : Int
    
    var body: some View {
        ZStack {
            Color(red: 37/255, green: 51/255, blue: 52/255)
            if showMenu {
                MenuView(showMenu: $showMenu)
            } else {
                ProfileInView(showMenu: $showMenu, numberPage: $numberPage)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(numberPage: .constant(4))
    }
}

struct ProfileInView: View {
    
    @Binding var showMenu: Bool
    @Binding var numberPage : Int
    
    @State private var isShowPhotoLibrary = false
    @State var user = User(email: "", nickName: "", avatar: "", token: "")
    
    var columns: [GridItem] =
            Array(repeating: .init(.fixed(170)), count: 2)
    
    @State var imagesArray = [String]()
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
            Image("Hamburger")
                .resizable()
                .frame(width: 22, height: 18)
                .onTapGesture {
                    showMenu.toggle()
                }
            Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 43.41, height: 49)
            Spacer()
            Text("exit")
                .font(.custom("AlegreyaSans-Medium", size: 15))
                .foregroundColor(.white)
                .onTapGesture {
                    let user = User(email: "", nickName: "", avatar: "", token: "")
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(user), forKey: "user")
                    numberPage = 2
                   
                }
        } .padding(.horizontal, 25).padding(.top, 75)
            WebImage(url: URL(string: user.avatar))
                .resizable()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
            Text(user.nickName)
                .font(.custom("AlegreyaSans-Medium", size: 35))
                .foregroundColor(.white)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(imagesArray, id: \.self) { i in
                        ZStack {
                            Image(uiImage: Helper().loadImageFromDocumentDirectory(nameOfImage: i))
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
            ImagePickerView(isPresented: $isShowPhotoLibrary)
                .onDisappear(perform: {
                if let photoArray = UserDefaults.standard.array(forKey: "photo") {
                    self.imagesArray = photoArray as! [String]
                }
            })
        })
        .onAppear(perform: {
            let defaults = UserDefaults.standard
            guard let userData = defaults.object(forKey: "user") as? Data else {
                return
            }
            guard let user = try? PropertyListDecoder().decode(User.self, from: userData) else {
                return
            }
            self.user = user
            
            if let photoArray = UserDefaults.standard.array(forKey: "photo") {
                self.imagesArray = photoArray as! [String]
            }
        })
    }
}





