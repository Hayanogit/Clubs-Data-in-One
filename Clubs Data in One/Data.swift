//
//  Data.swift
//  Clubs Data in One
//
//  Created by HAYATO OI on 2023/05/29.
//

import Foundation
import RealmSwift

class Data: Object{
    @objc dynamic var Date: String = ""
    @objc dynamic var Event: String = ""
    @objc dynamic var Time: String = ""
}
