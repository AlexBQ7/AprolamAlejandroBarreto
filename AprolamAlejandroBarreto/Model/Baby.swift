//
//  Baby.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 09/08/22.
//

import Foundation

struct BabyItem {
    
    enum Gender {
        case boy
        case girl
    }
    
    let name: String
    let birthday: Date
    let baby_gender: Gender
}
