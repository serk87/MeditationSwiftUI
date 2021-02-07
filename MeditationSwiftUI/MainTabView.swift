//
//  MainTabView.swift
//  MeditationSwiftUI
//
//  Created by Администратор on 07.02.2021.
//

import SwiftUI

struct MainTabView: View {
    
    
    @Binding var numberPage : Int
    @State var selected = 1
    
    
    
    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                MainView().tabItem { selected == 1 ? Image("logoMini"):Image("Home") }.tag(1)
                SoundView().tabItem { selected == 2 ? Image("sounds"):Image("unSounds")}.tag(2)
                ProfileView().tabItem { selected == 3 ? Image("profile"):Image("unProfile") }.tag(3)
            }
            
        }
        .onAppear(perform: {
            UITabBar.appearance().barTintColor = UIColor(red: 37/255, green: 51/255, blue: 52/255, alpha: 1.0)
        })
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(numberPage: .constant(4))
    }
}
