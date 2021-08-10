//
//  MeditationSwiftUIApp.swift
//  MeditationSwiftUI
//
//  Created by  Sergey Klimovich on 06.02.2021.
//

import SwiftUI
import UIKit
import Foundation

@main
struct MeditationSwiftUIApp: App {
    
    private var user = User(email: "", nickName: "", avatar: "", token: "")
    
    init() {
        if UserDefaultsData.shared.getData(key: "user").nickName != "" {
            self.user = UserDefaultsData.shared.getData(key: "user")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(numberPage: user.token == "" ? 1:4)
        }
    }
}

