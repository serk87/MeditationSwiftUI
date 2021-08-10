//
//  Quote.swift
//  MeditationSwiftUI
//
//  Created by v on 10.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI


class Quote: ObservableObject {
    
    @Published var quotes = [QuoteModel]()
    @Published var error = ""
    
    init() {
        getQuotes()
    }
    
    func getQuotes() {
        
        let url = "http://mskko2021.mad.hakta.pro/api/quotes"
        
        AF.request(url, method: .get).validate().responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["data"].arrayValue {
                    self.quotes.append(QuoteModel(title: item["title"].stringValue, image: item["image"].stringValue, description: item["description"].stringValue))
                }
            case .failure(_):
                let error = JSON(response.data)
                self.error = error["error"].stringValue
            }
        }
    }
}
