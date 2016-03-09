//: [Next](@next)
import Foundation
import UIKit

/**
 - note: This method returns an estimate.
 - todo: Add tests.
 - returns: A string with an € value.
 */
func estimateMoneySaving() -> String {
  
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "yyyy.MM.dd"
  
  let date = dateFormatter.dateFromString("2015.12.25")!

  let calendar: NSCalendar = NSCalendar.currentCalendar()
  let day = NSCalendarUnit.Day
  
  let dateComponents = calendar.components(day, fromDate: date, toDate: NSDate(), options: [])
  
  let daysPast = Double(dateComponents.day)
  
  let 🚬 = 6.0 / 7.0
  let 📦 = round(daysPast * 🚬)
  let 💸 = 5.5
  let 💶	 = 📦 * 💸
  
  let numberFormatter = NSNumberFormatter()
  numberFormatter.numberStyle = .CurrencyStyle
  numberFormatter.locale = NSLocale(localeIdentifier: "de_DE")
  
  return numberFormatter.stringFromNumber(💶)!
}


estimateMoneySaving()
