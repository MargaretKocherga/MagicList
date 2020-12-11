//
//  CalendarViewController.swift
//  Checklist
//
//  Created by Margo on 9.12.20.
//

import SwiftUI

struct CalendarViewController: View {
    
    @Binding var isPresented: Bool
    
    @ObservedObject var calendarManager: CalendarManager
    @ObservedObject var checklist: Checklist
    
    var body: some View {
        Group {
            CalendarWeekdayHeader(calendarManager: self.calendarManager)
            Divider()
            List {
                ForEach(0..<numberOfMonths()) { index in
                    CalendarMonth(isPresented: self.$isPresented, calendarManager: self.calendarManager, checklist: self.checklist, monthOffset: index)
                }
                Divider()
            }
        }
    }
    
    func numberOfMonths() -> Int {
        return calendarManager.calendar.dateComponents([.month], from: calendarManager.minimumDate, to: CalendarMaximumDateMonthLastDay()).month! + 1
    }
    
    func CalendarMaximumDateMonthLastDay() -> Date {
        var components = calendarManager.calendar.dateComponents([.year, .month, .day], from: calendarManager.maximumDate)
        components.month! += 1
        components.day = 0
        
        return calendarManager.calendar.date(from: components)!
    }
}

#if DEBUG
struct CalendarViewController_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CalendarViewController(isPresented: .constant(false), calendarManager: CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), checklist: Checklist(selectedDate: Date()))
            CalendarViewController(isPresented: .constant(false), calendarManager: CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*32)), checklist: Checklist(selectedDate: Date()))
                .environment(\.colorScheme, .dark)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
#endif
