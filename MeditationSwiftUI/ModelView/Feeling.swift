//
//  Feeling.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 10.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI


class Felling: ObservableObject {
    
    @Published var feelings = [FeelingModel]()
    @Published var error = ""
    
    init() {
        getFelling()
    }
    
    func getFelling() {
        let url = "http://mskko2021.mad.hakta.pro/api/feelings"
        AF.request(url, method: .get).validate().responseJSON { [unowned self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["data"].arrayValue {
                    self.feelings.append(FeelingModel(title: item["title"].stringValue, image: item["image"].stringValue, position: item["position"].stringValue))
                }
                let sortedFeelings =  self.feelings.sorted { $0.position < $1.position}
                self.feelings = sortedFeelings
            case .failure(_):
                let error = JSON(response.data)
                self.error = error["error"].stringValue
            }
        }
    }
}
