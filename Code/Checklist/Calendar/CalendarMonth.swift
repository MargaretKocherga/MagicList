//
//  CalendarMonth.swift
//  Checklist
//
//  Created by Margo on 9.12.20.
//

import SwiftUI

struct CalendarMonth: View {

    @Binding var isPresented: Bool
    
    @ObservedObject var calendarManager: CalendarManager
    @ObservedObject var checklist: Checklist
    
    let monthOffset: Int
    
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    let daysPerWeek = 7
    var monthsArray: [[Date]] {
        monthArray()
    }
    let cellWidth = CGFloat(32)
    
    @State var showTime = false
    
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10){
            Text(getMonthHeader()).foregroundColor(self.calendarManager.colors.monthHeaderColor)
            VStack(alignment: .leading, spacing: 5) {
                ForEach(monthsArray, id:  \.self) { row in
                    HStack() {
                        ForEach(row, id:  \.self) { column in
                            HStack() {
                                Spacer()
                                if self.isThisMonth(date: column) {
                                    CalendarCell(calendarDate: CalendarDate(
                                        date: column,
                                        calendarManager: self.calendarManager,
                                        isDisabled: !self.isEnabled(date: column),
                                        isToday: self.isToday(date: column),
                                        isSelected: self.isSelectedDate(date: column)),
                                        cellWidth: self.cellWidth)
                                        .onTapGesture { self.dateTapped(date: column) }
                                } else {
                                    Text("").frame(width: self.cellWidth, height: self.cellWidth)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        }.background(calendarManager.colors.monthBackColor)
    }

     func isThisMonth(date: Date) -> Bool {
         return self.calendarManager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
     }
    
    func dateTapped(date: Date) {
        if self.isEnabled(date: date) {
            if self.calendarManager.selectedDate != nil &&
                self.calendarManager.calendar.isDate(self.calendarManager.selectedDate, inSameDayAs: date) {
                self.calendarManager.selectedDate = nil
                self.checklist.selectedDate = nil
            } else {
                self.calendarManager.selectedDate = date
                self.checklist.selectedDate = date
            }
            self.isPresented = false
        }
    }
     
    func monthArray() -> [[Date]] {
        var rowArray = [[Date]]()
        for row in 0 ..< (numberOfDays(offset: monthOffset) / 7) {
            var columnArray = [Date]()
            for column in 0 ... 6 {
                let abc = self.getDateAtIndex(index: (row * 7) + column)
                columnArray.append(abc)
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    func getMonthHeader() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = calendarManager.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: calendarManager.calendar.locale)
        
        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }
    
    func getDateAtIndex(index: Int) -> Date {
        let firstOfMonth = firstOfMonthForOffset()
        let weekday = calendarManager.calendar.component(.weekday, from: firstOfMonth)
        var startOffset = weekday - calendarManager.calendar.firstWeekday
        startOffset += startOffset >= 0 ? 0 : daysPerWeek
        var dateComponents = DateComponents()
        dateComponents.day = index - startOffset
        
        return calendarManager.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
    }
    
    func numberOfDays(offset : Int) -> Int {
        let firstOfMonth = firstOfMonthForOffset()
        let rangeOfWeeks = calendarManager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)
        
        return (rangeOfWeeks?.count)! * daysPerWeek
    }
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset
        
        return calendarManager.calendar.date(byAdding: offset, to: calendarFirstDateMonth())!
    }
    
    func calendarFormatDate(date: Date) -> Date {
        let components = calendarManager.calendar.dateComponents(calendarUnitYMD, from: date)
        
        return calendarManager.calendar.date(from: components)!
    }
    
    func calendarFormatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = calendarFormatDate(date: referenceDate)
        let clampedDate = calendarFormatDate(date: date)
        return refDate == clampedDate
    }
    
    func calendarFirstDateMonth() -> Date {
        var components = calendarManager.calendar.dateComponents(calendarUnitYMD, from: calendarManager.minimumDate)
        components.day = 1
        
        return calendarManager.calendar.date(from: components)!
    }
    
    // MARK: - Date Property Checkers
    
    func isToday(date: Date) -> Bool {
        return calendarFormatAndCompareDate(date: date, referenceDate: Date())
    }

    func isSelectedDate(date: Date) -> Bool {
        if calendarManager.selectedDate == nil {
            return false
        }
        return calendarFormatAndCompareDate(date: date, referenceDate: calendarManager.selectedDate)
    }
    
    func isEnabled(date: Date) -> Bool {
        let clampedDate = calendarFormatDate(date: date)
        if calendarManager.calendar.compare(clampedDate, to: calendarManager.minimumDate, toGranularity: .day) == .orderedAscending || calendarManager.calendar.compare(clampedDate, to: calendarManager.maximumDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
}

#if DEBUG
struct CalendarMonth_Previews : PreviewProvider {
    static var previews: some View {
        CalendarMonth(isPresented: .constant(false),calendarManager: CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), checklist: Checklist(selectedDate: Date()), monthOffset: 0)
    }
}
#endif
