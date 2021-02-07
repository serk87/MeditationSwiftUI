//
//  SignInView.swift
//  MeditationSwiftUI
//
//  Created by Администратор on 06.02.2021.
//

import SwiftUI

struct SignInView: View {
    
    @Binding var numberPage: Int
    @State var email = ""
    @State var password = ""
    @State var showAlertEmpty = false
    @State var showAlertEmail = false
    
    var body: some View {
        ZStack {
            Color(red: 37/255, green: 51/255, blue: 52/255)
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 30) {
                        Image("logo")
                            .resizable()
                            .frame(width: 43.49, height: 49)
                        Text("Вход")
                            .font(.custom("Alegreya-Medium", size: 30))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }.padding(.leading, 35)
                
                Spacer()
                
                CustomTextField(placeholder: Text("Email"), text: $email)
                    .padding(.horizontal, 30).padding(.bottom, 50)
                
                CustomTextField(placeholder: Text("Пароль"), text: $password)
                    .padding(.horizontal, 30).padding(.bottom, 50)
                
                Button(action: {
                    if email == "" || password == "" {
                        showAlertEmpty.toggle()
                    }
                    if email.contains("@") {
                        numberPage = 4
                    } else {
                        showAlertEmail.toggle()
                    }
                    
                }, label: {
                    Text("ВОЙТИ")
                        .font(.custom("AlegreyaSans-Medium", size: 20))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 61, alignment: .center)
                        .background(Color(red: 124/255, green: 154/255, blue: 146/255))
                        .cornerRadius(10)
                })
                .alert(isPresented: $showAlertEmpty, content: {
                    Alert(title: Text("Ошибка"), message: Text("Не должно быть пустых полей"), dismissButton: .default(Text("OK")))
                })
                
                HStack {
                    Text("Еще нет аккаунта? ")
                        .font(.custom("Alegreya-Regular", size: 20))
                        .foregroundColor(.white)
                    Text("Зарегистрируйтесь")
                        .font(.custom("Alegreya-Medium", size: 20))
                        .foregroundColor(.white)
                        .onTapGesture {
                            numberPage = 3
                        }
                }.padding(.top)
                .alert(isPresented: $showAlertEmail, content: {
                    Alert(title: Text("Ошибка"), message: Text("Email должен содержать @"), dismissButton: .default(Text("OK")))
                })
                Spacer()
                Image("backgroundSignIn")
                
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(numberPage: .constant(2))
    }
}


struct CustomTextField: View {
    var placeholder: Text
    @Binding var  text: String
    var ediitingChange: (Bool)->() = { _ in }
    var commit: ()->() = {}

    var body : some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder.font(.custom("AlegreyaSans-Regular", size: 18)).foregroundColor(Color(red: 190/255, green: 194/255, blue: 194/255))}
            VStack {
                TextField("", text: $text, onEditingChanged: ediitingChange, onCommit: commit)
                    .padding(.top, 5).padding(.bottom)
                    .foregroundColor(.white)
                Rectangle().frame(height: 1).foregroundColor(Color(red: 190/255, green: 194/255, blue: 194/255))
            }
        }
    }
}
