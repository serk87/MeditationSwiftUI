//
//  RegistrationView.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 06.02.2021.
//

import SwiftUI

struct RegistrationView: View {
    
    @Binding var numberPage: Int
    
    var body: some View {
        ZStack {
            Color(red: 37/255, green: 51/255, blue: 52/255)
            VStack {
                Spacer()
                Text("Тут будет\nрегистрация")
                    .font(.custom("Alegreya-Medium", size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    numberPage = 2
                }, label: {
                    Text("НАЗАД")
                        .font(.custom("AlegreyaSans-Medium", size: 20))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 61, alignment: .center)
                        .background(Color(red: 124/255, green: 154/255, blue: 146/255))
                        .cornerRadius(10)
                }).padding(.bottom)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(numberPage: .constant(3))
    }
}
