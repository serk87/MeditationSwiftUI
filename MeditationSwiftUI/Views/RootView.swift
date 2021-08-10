//
//  RootView.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 06.02.2021.
//

import SwiftUI

struct RootView: View {
    
    @State var numberPage = 1
    
    var body: some View {
        if numberPage == 1 {
            OnBoardView(numberPage: $numberPage)
        } else if numberPage == 2 {
            SignInView(numberPage: $numberPage)
        } else if numberPage == 3 {
            RegistrationView(numberPage: $numberPage)
        } else if numberPage == 4 {
            MainTabView(numberPage: $numberPage)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(numberPage: 3)
    }
}
