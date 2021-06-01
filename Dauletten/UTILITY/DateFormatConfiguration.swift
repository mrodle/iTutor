//
//  DateFormatConfiguration.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 12/24/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class DateFormatConfiguration {
    static var shared = DateFormatConfiguration()
    
    
    func dateStringSplit(date: String) -> [String] {
        var dateList: [String] = []
        var dateString = ""
        print(date)
        
        for character in date {
            if character == "-"{
                dateList.append(dateString)
                dateString = ""
            } else {
                dateString += String(character)
            }
        }
        dateList.append(dateString)
        
        return dateList
    }
    
    func getMonthIndex(index: String) -> Int {
        let monthIndex = ((Int(index.prefix(1)) ?? 1) * 10) + (Int(index.suffix(1)) ?? 1)
        
        return monthIndex
    }
    
    func getDate(by date: String) -> String {
        let monthPart = dateStringSplit(date: String(date.prefix(10)))[1]
        let dayPart = dateStringSplit(date: String(date.prefix(10)))[2]
        let yearPart = dateStringSplit(date: String(date.prefix(10)))[0]

        let monthIndex = ((Int(monthPart.prefix(1)) ?? 1) * 10) + (Int(monthPart.suffix(1)) ?? 1)

        let monthList = ["қаңтар", "ақпан", "наурыз", "сәуір", "мамыр", "маусым", "шілде", "тамыз", "қыркүйек", "қазан", "қараша", "желтоқсан"]
        
        let month = monthList[monthIndex - 1]
        
        return "\(dayPart) \(month), \(yearPart) жыл"

    }
    
    func getMonthInString(index: Int) -> String {
        let monthList = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
        
        let month = monthList[index - 1]
        
        return month
    }
    
    func getStringMonthIndex(month: String) -> String {
        var monthIndex = String()
        let monthList = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
        
        for index in 0 ..< monthList.count {
            if month == monthList[index] {
                if String(index).count == 1 {
                    monthIndex = "0\(String(index + 1))"
                } else {
                    monthIndex = "\(index + 1)"
                }
            }
        }
        
        return monthIndex
    }
}

class AgeConfiguration {
    static var shared = AgeConfiguration()
    
    func getAgeFrom(birthdate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        let date = formatter.date(from: birthdate)!
        let now = Date()
        let birthday: Date = date
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!

        return "\(age)"
    }

    func getValidateBirthday(date: Date) -> Bool {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDate = Date()
        if currentDate >= date {
            return true
        } else {
            return false
        }
    }

    func getValidateEventDay(date: Date) -> Bool {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDate = Date()
        if currentDate < date {
            return true
        } else {
            return false
        }
        
    }

}
