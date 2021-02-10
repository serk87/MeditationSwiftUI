//
//  Auth.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 10.02.2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class Auth: ObservableObject {
    
    @Published var user = User(email: "", nickName: "", avatar: "", token: "")
    @Published var error = ""
    
    
    func signIn(email: String, password: String) {
        let url = "http://mskko2021.mad.hakta.pro/api/user/login"
        let parameters: [String: String] = [
                    "email": email,
                    "password": password
                ]

        AF.request(url, method: .post, parameters:parameters, encoder: JSONParameterEncoder.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let email = json["email"].stringValue
                let token = json["token"].stringValue
                let avatar = json["avatar"].stringValue
                let nickName = json["nickName"].stringValue
                let user = User(email: email, nickName: nickName, avatar: avatar, token: token)
                self.user = user
                UserDefaults.standard.set(try? PropertyListEncoder().encode(user), forKey: "user")
            
            case .failure(_):
                let error = JSON(response.data)
                self.error = error["error"].stringValue
                print(error["error"].stringValue)
            }
        }
    }
}
