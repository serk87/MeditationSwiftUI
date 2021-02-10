//
//  MeditationSwiftUIApp.swift
//  MeditationSwiftUI
//
//  Created by Администратор on 06.02.2021.
//

import SwiftUI
import UIKit
import Foundation

@main
struct MeditationSwiftUIApp: App {
    private var user = User(email: "", nickName: "", avatar: "", token: "")
    init() {
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: "user") as? Data else {
            return
        }
        guard let user = try? PropertyListDecoder().decode(User.self, from: userData) else {
            return
        }
        self.user = user
    }
    var body: some Scene {
        WindowGroup {
            RootView(numberPage: user.token == "" ? 1:4)
        }
    }
}

