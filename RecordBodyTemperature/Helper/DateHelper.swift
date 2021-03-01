//
//  DateHelper.swift
//  RecordBodyTemperature
//
//  Created by 神村亮佑 on 2021/02/01.
//

import Foundation

struct DateHelper {
    
    static let instance = DateHelper()
    
    func date2String(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ja_JP")
        return dateFormatter.string(from: date)
    }
}
