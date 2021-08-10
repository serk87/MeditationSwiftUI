//
//  SoundView.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 07.02.2021.
//

import SwiftUI

struct SoundView: View {
    var body: some View {
        ZStack {
            Color(red: 37/255, green: 51/255, blue: 52/255)
                Text("Тут будет\nпрослушивание")
                    .font(.custom("Alegreya-Medium", size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        SoundView()
    }
}
