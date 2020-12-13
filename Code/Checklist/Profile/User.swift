//
//  User.swift
//  Checklist
//
//  Created by Margo on 11.12.20.
//

import Foundation

class User: Codable {
    var name: String
    var photo: Data?
    var daysStreak: Int
    
    //  Methods
    //  =======
    init(name: String = "", photo: Data? = nil, daysStreak: Int = 0) {
        self.name = name
        self.photo = photo
        self.daysStreak = daysStreak
    }
    
    
}
