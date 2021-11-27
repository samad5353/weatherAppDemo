//
//  Utilities.swift
//  weatherApp
//
//  Created by Abdul Samad on 11/27/21.
//

import Foundation

class Utilities {
    
    static let shared = Utilities()
    
    func getDayFromDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return "-"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: inputDate)
    }
    
    func getTimeFromDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return "-"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: inputDate)
    }
    
    func getHourFromDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return "-"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from: inputDate)
    }
    
}



