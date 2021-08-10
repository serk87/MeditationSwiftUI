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
    
    func signIn(email: String, password: String, completionHandler: (@escaping(_ result: User,_ error: String) -> Void)) {
        let url = "http://mskko2021.mad.hakta.pro/api/user/login"
        let parameters: [String: String] = [
                    "email": email,
                    "password": password
                ]
        AF.request(url, method: .post, parameters:parameters, encoder: JSONParameterEncoder.default).validate().responseJSON { [unowned self] response in
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
                completionHandler(user, "Success")
            case .failure(let error):
                let errorJson = JSON(response.data)
                let errorDescription = errorJson["error"].stringValue
                completionHandler(self.user, errorDescription)
            }
            
        }
    }
    
}
