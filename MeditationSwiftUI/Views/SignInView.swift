//
//  SignInView.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 06.02.2021.
//

import SwiftUI

struct SignInView: View {
    
    @Binding var numberPage: Int
    @State var email = ""
    @State var password = ""
    @State var showAlert = false
    @State var errorMsg = ""
    
    @ObservedObject var auth = Auth()
    
    var body: some View {
        ZStack {
            Color(red: 37/255, green: 51/255, blue: 52/255)
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 30) {
                        Image("Logo")
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
                        self.errorMsg = "Поле Email и пароль не могут быть пустыми"
                        showAlert.toggle()
                    } else if email.contains("@") {
                        auth.signIn(email: email, password: password) { user, error  in
                            if error != "Success" {
                                self.errorMsg = error
                                showAlert.toggle()
                            } else {
                                numberPage = 4
                            }
                        }
                    } else {
                        self.errorMsg = "В поле Email должна использоваться @"
                        showAlert.toggle()
                    }
                    
                }, label: {
                    Text("ВОЙТИ")
                        .font(.custom("AlegreyaSans-Medium", size: 20))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 61, alignment: .center)
                        .background(Color(red: 124/255, green: 154/255, blue: 146/255))
                        .cornerRadius(10)
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Ошибка"), message: Text(errorMsg), dismissButton: .default(Text("OK")))
                   
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
                
                Spacer()
                Image("backgroundSignIn")
                
            }
        }.edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            if UserDefaultsData.shared.getData(key: "user").nickName != "" {
                self.email = UserDefaultsData.shared.getData(key: "user").email
            }
        })
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
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.top, 5).padding(.bottom)
                    .foregroundColor(.white)
                Rectangle().frame(height: 1).foregroundColor(Color(red: 190/255, green: 194/255, blue: 194/255))
            }
        }
    }
}
