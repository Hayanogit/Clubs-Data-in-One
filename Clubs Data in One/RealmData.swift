//
//  Data.swift
//  Clubs Data in One
//
//  Created by HAYATO OI on 2023/05/29.
//

import Foundation
import RealmSwift

class RealmData: Object{
    @objc dynamic var date: String = ""
    @objc dynamic var event: String = ""
    @objc dynamic var time: Double = 0.0
}
