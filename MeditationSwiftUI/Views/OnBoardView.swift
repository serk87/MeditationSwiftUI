//
//  OnBoardView.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 06.02.2021.
//

import SwiftUI

struct OnBoardView: View {
    
    @Binding var numberPage: Int
    
    var body: some View {
        ZStack {
            Image("BackgroundSplash").resizable().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            VStack {
                Spacer()
                Image("Logo").resizable().frame(width: 191, height: 199, alignment: .center)
                Text("ПРИВЕТ").font(.custom("Alegreya-Bold", size: 34)).foregroundColor(.white).padding(.bottom, 3)
                Text("Наслаждайся отборочными.\nБудь внимателен.\nДелай хорошо.")
                    .font(.custom("AlegreyaSans-Medium", size: 20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
                Button(action: {
                    numberPage = 2
                }, label: {
                    Text("Войти в аккаунт")
                        .font(.custom("AlegreyaSans-Medium", size: 20))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 61, alignment: .center).background(Color(red: 124/255, green: 154/255, blue: 146/255))
                        .cornerRadius(10)
                        .padding(.bottom)
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
                }
                Spacer()
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView(numberPage: .constant(1))
    }
}
