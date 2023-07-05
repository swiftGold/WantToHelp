//
//  CalendarManager.swift
//  Block1
//
//  Created by Сергей Золотухин on 31.05.2023.
//

import UIKit

protocol CalendarManagerProtocol {
  func fetchStringDateFromTimeStamp(ti: TimeInterval) -> String
  func fetchFullStringDateFromTimeStamp(ti: TimeInterval) -> String
  func fetchDateFromTimeStamp(ti: TimeInterval) -> Date
  func howMuchdaysLeft(currentDate: Date, eventDate: Date) -> Int?
}

final class CalendarManager {
  let calendar = Calendar.current
  let dateFormatter = DateFormatter()
}

enum DateType: String {
  case LLLL
  case yyyy
}

extension CalendarManager: CalendarManagerProtocol {
  func format(date: Date, dateType: DateType) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateType.rawValue
    return dateFormatter.string(from: date)
  }
  
  func format(dateString: String, dateType: DateType) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateType.rawValue
    return dateFormatter.date(from: dateString)
  }
  
  func plusMonth(date: Date) -> Date? {
    return calendar.date(byAdding: .month, value: 1, to: date)
  }
  
  func minusMonth(date: Date) -> Date? {
    return calendar.date(byAdding: .month, value: -1, to: date)
  }
  
  // название месяца
  func monthString(date: Date) -> String {
    return format(date: date, dateType: .LLLL)
  }
  
  // название года
  func yearString(date: Date) -> String {
    return format(date: date, dateType: .yyyy)
  }
  
  // Количество дней в месяце
  func daysInMonth(date: Date) -> Int? {
    let range = calendar.range(of: .day, in: .month, for: date)
    return range?.count
  }
  
  // номер дня в месяце
  func dayOfMonth(date: Date) -> Int? {
    let components = calendar.dateComponents([.day], from: date)
    return components.day
  }
  
  // номер первого дня в месяце (на основе года и месяца)
  func firstOfMonth(date: Date) -> Date? {
    let components = calendar.dateComponents([.year, .month], from: date)
    if let day = calendar.date(from: components) {
      dateFormatter.timeZone = TimeZone(secondsFromGMT: +3)
      dateFormatter.dateFormat = "yyyy-MM-dd"
      let newDate = dateFormatter.string(from: day)
      let dateDate = dateFormatter.date(from: newDate)
      return dateDate
    } else {
      return Date()
    }
  }
  
  // номер первого дня месяца в неделе
  func weekDay(date: Date) -> Int {
    let components = calendar.dateComponents([.weekday], from: date)
    if let weekDay = components.weekday {
      var emptyFields = weekDay + 6
      if emptyFields >= 7 {
        emptyFields -= 7
      }
      return emptyFields
    } else {
      return 9999
    }
  }
  
  //Строковое значение номера дня из полной даты с учетом таймзоны
  func dayNumberFromFullDate(date: Date?) -> String {
    guard let date = date else {
      return ""
    }
    let component = calendar.component(.day, from: date)
    return String(component)
  }
  
  //проверка на одинаковость выбранной даты и даты из календаря, с целью отобразить задачи определенного дня
  func isDatesEqual(firstDate: Date?, secondDate: Date?) -> Bool {
    guard let firstDate = firstDate,
          let secondDate = secondDate else {
      return false
    }
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let firstDateString = dateFormatter.string(from: firstDate)
    let secondDateString = dateFormatter.string(from: secondDate)
    return firstDateString == secondDateString
  }
  
  //Строковое значение времени дня из полной даты с учетом таймзоны
  func timeFromFullDate(date: Date) -> String {
    dateFormatter.dateFormat = "H:mm"
    return dateFormatter.string(from: date)
  }
  
  //Строковое значение часа из полной даты с учетом таймзоны
  func hourFromFullDate(date: Date) -> String {
    dateFormatter.dateFormat = "H"
    dateFormatter.timeZone = .current
    return dateFormatter.string(from: date)
  }
  
  //Строковое значение часа из полной даты с учетом таймзоны
  func dateFromFullDate(date: Date?) -> String {
    var hour = ""
    if let date = date {
      dateFormatter.dateFormat = "yyyy-MM-dd"
      dateFormatter.timeZone = .current
      hour = dateFormatter.string(from: date)
    }
    return hour
  }
  
  //Сохраняем дату в формате TimeStamp
  func saveDateInTimeStamp(date: Date) -> TimeInterval {
    let timeStamp = date.timeIntervalSince1970
    return timeStamp
  }
  
  //Получаем строковое значение даты (день и месяц) из timeStamp с учетом часового пояса
  func fetchStringDateFromTimeStamp(ti: TimeInterval) -> String {
    let dateFromUnix = Date(timeIntervalSince1970: ti)
    dateFormatter.dateFormat = "dd.MM"
    dateFormatter.timeZone = .current
    let dateString = dateFormatter.string(from: dateFromUnix)
    return dateString
  }
  
  //Получаем строковое значение даты (день и месяц и год) из timeStamp с учетом часового пояса
  func fetchFullStringDateFromTimeStamp(ti: TimeInterval) -> String {
      let dateFromUnix = Date(timeIntervalSince1970: ti)
      dateFormatter.dateFormat = "MMM dd, YYYY"
      dateFormatter.timeZone = .current
      let dateString = dateFormatter.string(from: dateFromUnix)
      return dateString
  }
  
  //Получаем  значение даты из timeStamp с учетом часового пояса
  func fetchDateFromTimeStamp(ti: TimeInterval) -> Date {
    let dateFromUnix = Date(timeIntervalSince1970: ti)
    return dateFromUnix
  }
  
  //Сколько дней между двумя датами
  func howMuchdaysLeft(currentDate: Date, eventDate: Date) -> Int? {
    let numberOfDays = calendar.dateComponents([.day], from: currentDate, to: eventDate)
    return numberOfDays.day
  }
}

