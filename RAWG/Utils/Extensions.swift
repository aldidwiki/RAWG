//
//  Extensions.swift
//  RAWG
//
//  Created by Aldi Dwiki Prahasta on 09/10/22.
//

import Foundation

extension Date {
    func formatDateToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    func formatStringToDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)!
    }
}
