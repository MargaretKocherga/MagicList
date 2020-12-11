//
//  CalendarManager.swift
//  Checklist
//
//  Created by Margo on 7.12.20.
//

import SwiftUI

class CalendarManager : ObservableObject {
    @Published var calendar = Calendar.current
    @Published var minimumDate: Date = Date()
    @Published var maximumDate: Date = Date()
    @Published var disabledDates: [Date] = [Date]()
    @Published var selectedDate: Date! = Date()
    
    var colors = CalendarColorSettings()
  
    init(calendar: Calendar, minimumDate: Date, maximumDate: Date) {
        self.calendar = calendar
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
    }
    
    
}
