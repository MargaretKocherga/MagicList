//
//  CalendarWeekdayHeader.swift
//  Checklist
//
//  Created by Margo on 9.12.20.
//

import SwiftUI

struct CalendarWeekdayHeader : View {
    
    var calendarManager: CalendarManager
     
    var body: some View {
        HStack(alignment: .center) {
            ForEach(self.getWeekdayHeaders(calendar: self.calendarManager.calendar), id: \.self) { weekday in
                Text(weekday)
                    .font(.system(size: 20))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(self.calendarManager.colors.weekdayHeaderColor)
            }
        }.background(calendarManager.colors.weekdayHeaderBackColor)
    }
    
    func getWeekdayHeaders(calendar: Calendar) -> [String] {
        
        let formatter = DateFormatter()
        
        var weekdaySymbols = formatter.shortStandaloneWeekdaySymbols
        let weekdaySymbolsCount = weekdaySymbols?.count ?? 0
        
        for _ in 0 ..< (1 - calendar.firstWeekday + weekdaySymbolsCount){
            let lastObject = weekdaySymbols?.last
            weekdaySymbols?.removeLast()
            weekdaySymbols?.insert(lastObject!, at: 0)
        }
        
        return weekdaySymbols ?? []
    }
}


#if DEBUG
struct CalendarWeekdayHeader_Previews : PreviewProvider {
    static var previews: some View {
        CalendarWeekdayHeader(calendarManager: CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)))
    }
}
#endif
