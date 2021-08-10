//
//  MainTabView.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 07.02.2021.
//

import SwiftUI

struct MainTabView: View {
    
    @Binding var numberPage : Int
    @State var selected = 1
    
    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                MainView().tabItem { selected == 1 ? Image("logoMini"):Image("Home") }.tag(1)
                SoundView().tabItem { selected == 2 ? Image("soundsIcon"):Image("unSounds")}.tag(2)
                ProfileView(numberPage: $numberPage).tabItem { selected == 3 ? Image("profileIcon"):Image("unProfile") }.tag(3)
            }.background(Color.blue)
            
        }
        
    }
}

