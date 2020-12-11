//
//  CalendarCell.swift
//  Checklist
//
//  Created by Margo on 9.12.20.
//

import SwiftUI

struct CalendarCell: View {
    
    var calendarDate: CalendarDate
    var cellWidth: CGFloat
    
    var body: some View {
        Text(calendarDate.getText())
            .fontWeight(calendarDate.getFontWeight())
            .foregroundColor(calendarDate.getTextColor())
            .frame(width: cellWidth, height: cellWidth)
            .font(.system(size: 20))
            .background(calendarDate.getBackgroundColor())
            .cornerRadius(cellWidth/2)
    }
}


#if DEBUG
struct CalendarCell_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CalendarCell(calendarDate: CalendarDate(date: Date(), calendarManager: CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: false, isSelected: false), cellWidth: CGFloat(32))
                .previewDisplayName("Control")
            CalendarCell(calendarDate: CalendarDate(date: Date(), calendarManager: CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: true, isToday: false, isSelected: false), cellWidth: CGFloat(32))
                .previewDisplayName("Disabled Date")
            CalendarCell(calendarDate: CalendarDate(date: Date(), calendarManager: CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: true, isSelected: false), cellWidth: CGFloat(32))
                .previewDisplayName("Today")
            CalendarCell(calendarDate: CalendarDate(date: Date(), calendarManager: CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: false, isSelected: true), cellWidth: CGFloat(32))
                .previewDisplayName("Selected Date")
        }
        .previewLayout(.fixed(width: 300, height: 70))
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
#endif
