//
//  Date.swift
//  Checklist
//
//  Created by Margo on 7.12.20.
//

import SwiftUI

struct CalendarDate {
    var date: Date
    let calendarManager: CalendarManager
    
    var isDisabled: Bool = false
    var isToday: Bool = false
    var isSelected: Bool = false

    init(date: Date, calendarManager: CalendarManager, isDisabled: Bool, isToday: Bool, isSelected: Bool) {
        self.date = date
        self.calendarManager = calendarManager
        self.isDisabled = isDisabled
        self.isToday = isToday
        self.isSelected = isSelected
    }
    
    func getText() -> String {
        let day = formatDate(date: date, calendar: self.calendarManager.calendar)
        return day
    }
    
    func getTextColor() -> Color {
        var textColor = calendarManager.colors.textColor
        if isDisabled {
            textColor = calendarManager.colors.disabledColor
        } else if isSelected {
            textColor = calendarManager.colors.selectedColor
        } else if isToday {
            textColor = calendarManager.colors.todayColor
        }
        return textColor
    }
    
    func getBackgroundColor() -> Color {
        var backgroundColor = calendarManager.colors.textBackColor
        
        if isToday {
            backgroundColor = calendarManager.colors.todayBackColor
        }
        if isDisabled {
            backgroundColor = calendarManager.colors.disabledBackColor
        }
        if isSelected {
            backgroundColor = calendarManager.colors.selectedBackColor
        }
        return backgroundColor
    }
    
    func getFontWeight() -> Font.Weight {
        var fontWeight = Font.Weight.medium
        if isDisabled {
            fontWeight = Font.Weight.thin
        } else if isSelected {
            fontWeight = Font.Weight.heavy
        } else if isToday {
            fontWeight = Font.Weight.heavy
        }
        return fontWeight
    }
    
    
    
    // MARK: - Date Formats
    
    func formatDate(date: Date, calendar: Calendar) -> String {
        let formatter = dateFormatter()
        return stringFrom(date: date, formatter: formatter, calendar: calendar)
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "d"
        return formatter
    }
    
    func stringFrom(date: Date, formatter: DateFormatter, calendar: Calendar) -> String {
        if formatter.calendar != calendar {
            formatter.calendar = calendar
        }
        return formatter.string(from: date)
    }
    
}
