//
//  SaveUserDefaultsData.swift
//  MeditationSwiftUI
//
//  Created by luser on 10.08.2021.
//

import Foundation


class UserDefaultsData {
    
    
    static let shared = UserDefaultsData()
    
    func getData(key: String) -> User {
        if let userData = UserDefaults.standard.object(forKey: key) as? Data  {
            if let user = try? PropertyListDecoder().decode(User.self, from: userData) {
                return user
            }else {
                
                return User(email: "", nickName: "", avatar: "", token: "")
            }
        } else {
            
            return User(email: "", nickName: "", avatar: "", token: "")
        }
    }
}
