//
//  MainView.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 07.02.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    @State var showMenu = false
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(red: 37/255, green: 51/255, blue: 52/255, alpha: 1.0)
    }
    
    var body: some View {
        ZStack {
            Color(red: 37/255, green: 51/255, blue: 52/255)
            if showMenu {
                MenuView(showMenu: $showMenu)
            } else {
                MainInView(showMenu: $showMenu)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct MainInView: View {
    
    @Binding var showMenu: Bool
    @State var user = User(email: "", nickName: "", avatar: "", token: "")
    @ObservedObject var quotes = Quote()
    @ObservedObject var feeling = Felling()
  
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
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
                    WebImage(url: URL(string: user.avatar))
                        .placeholder(Image("avatar"))
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 35, height: 35)
                } .padding(.horizontal, 25).padding(.top, 75)
                Text("С возвращением, \(user.nickName)!")
                    .font(.custom("Alegreya-Medium", size: 30))
                    .foregroundColor(.white)
                Text("Каким ты себя ощущаешь сегодня?")
                    .font(.custom("AlegreyaSans-Regular", size: 22))
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .padding(.bottom, 40)
                VStack {
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            ForEach(feeling.feelings, id: \.self) { i in
                                VStack {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 62, height: 65)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                        WebImage(url: URL(string: i.image))
                                    }
                                    Text(i.title)
                                        .font(.custom("AlegreyaSans-Regular", size: 12))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 105)
                            }
                        }
                    }).padding(.horizontal).padding(.bottom, 20)
                    
                    
                    VStack(spacing: 20) {
                        ForEach(quotes.quotes, id: \.self) { i in
                            HStack(spacing: 0) {
                                ZStack {
                                    WebImage(url: URL(string: i.image))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 166, height: 111, alignment: .center)
                                        .padding(.leading, 150)
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(i.title)
                                            .font(.custom("Alegreya-Medium", size: 25))
                                        Text(i.description)
                                            .font(.custom("AlegreyaSans-Medium", size: 15))
                                        Button(action: {}, label: {
                                            Text("подбробнее")
                                                .font(.custom("AlegreyaSans-Medium", size: 15))
                                                .foregroundColor(.white)
                                                .frame(width: 138, height: 39)
                                                
                                                .background(Color(red: 37/255, green: 51/255, blue: 52/255))
                                        }).cornerRadius(10)
                                        
                                    }
                                    .padding(.trailing, UIScreen.main.bounds.width/3)
                                    .padding(.leading, 3.1)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width-30,height: 170)
                            .background(Color(red: 247/255, green: 243/255, blue: 240/255))
                            .cornerRadius(20)
                        }
                    }
                    
                }
            }
        })
        
        .onAppear(perform: {
            if UserDefaultsData.shared.getData(key: "user").nickName != "" {
                self.user = UserDefaultsData.shared.getData(key: "user")
            }
        })
    }
}

struct MenuView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack {
            Color(red: 37/255, green: 51/255, blue: 52/255)
            
            VStack {
                
                Spacer()
                
                Text("Тут будет меню")
                    .font(.custom("Alegreya-Medium", size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Button(action: {
                    showMenu.toggle()
                }, label: {
                    Text("НАЗАД")
                        .font(.custom("AlegreyaSans-Medium", size: 20))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 61, alignment: .center)
                        .background(Color(red: 124/255, green: 154/255, blue: 146/255))
                        .cornerRadius(10)
                }).padding(.bottom, 200)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
