//
//  DateFormat.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 09/08/22.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}
