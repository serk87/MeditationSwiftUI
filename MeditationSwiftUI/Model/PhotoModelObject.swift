//
//  PhotoModelObject.swift
//  MeditationSwiftUI
//
//  Created by Sergey Klimovich on 11.02.2021.
//

import Foundation
import RealmSwift


class PhotoModelObject: Object {
    @objc dynamic var photoName = ""
    @objc dynamic var time = ""
    
    override static func primaryKey() -> String? {
        return "photoName"
    }
}
