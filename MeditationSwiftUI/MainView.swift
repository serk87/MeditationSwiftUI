//
//  MainView.swift
//  MeditationSwiftUI
//
//  Created by Администратор on 07.02.2021.
//

import SwiftUI

struct MainView: View {
    @State var showMenu = false
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
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
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
                Text("С возвращением, Эмиль!")
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
                            ForEach(0...10, id: \.self) { i in
                                VStack {
                                    Rectangle()
                                        .frame(width: 62, height: 65)
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                    Text("Спокойным")
                                        .font(.custom("AlegreyaSans-Regular", size: 12))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }).padding(.horizontal).padding(.bottom, 20)
                    
                    
                    VStack(spacing: 20) {
                        ForEach(0...10, id: \.self) { i in
                            HStack(spacing: 0) {
                                ZStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Заголовок блока")
                                            .font(.custom("Alegreya-Medium", size: 25))
                                        Text("Кратенькое описание\nблока с двумя строчками")
                                            .font(.custom("AlegreyaSans-Medium", size: 15))
                                        Button(action: {}, label: {
                                            Text("подбробнее")
                                                .font(.custom("AlegreyaSans-Medium", size: 15))
                                                .foregroundColor(.white)
                                                .frame(width: 138, height: 39)
                                                
                                                .background(Color(red: 37/255, green: 51/255, blue: 52/255))
                                        }).cornerRadius(10)
                                        
                                    }.padding(.trailing, 120)
                                    Image("image").resizable()
                                        .frame(width: 166, height: 111, alignment: .center)
                                        .padding(.leading, 150)
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
