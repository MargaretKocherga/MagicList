//
//  ContentView.swift
//  Checklist
//
//  Created by Margo on 9/25/20.
//

import SwiftUI

struct ChecklistView: View {
    
    //  Properties
    //  ==========
    
    @State var newChecklistItemViewIsVisible = false
    @State var calendarIsVisible = false
    @ObservedObject var calendarManager = CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365))
    @ObservedObject var checklist = Checklist(selectedDate: Date())
    
    //  User interface content and layout
    //  =================================
    var body: some View {
        
        VStack {
            Spacer(minLength: 10)
            HStack(spacing: 90){
                Button(action: {
                    //  new view appears
                }) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 34,height:34)
                }
                Text(getCurrentDate())
                Button(action: {
                    self.calendarIsVisible = true
                }) {
                    Image(systemName: "calendar.circle.fill")
                        .resizable()
                        .frame(width: 34,height:34)
                }.sheet(isPresented: $calendarIsVisible, content: {
                            CalendarViewController(isPresented: self.$calendarIsVisible, calendarManager: self.calendarManager, checklist: self.checklist)})
            }.foregroundColor(.red)
            
            
            NavigationView {
                List {
                    ForEach(checklist.items) { index in
                        if(Calendar.current.compare(self.checklist.items[index].date,
                                                    to: calendarManager.selectedDate,
                                                    toGranularity: .day) == .orderedSame) {
                            RowView(checklistItem: self.$checklist.items[index])
                        }
                    }
                    .onDelete(perform: checklist.deleteListItem)
                    .onMove(perform: checklist.moveListItem)
                }
                .navigationBarItems(leading: Button(action: {
                    self.newChecklistItemViewIsVisible = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add item")
                    }
                    .foregroundColor(.red)
                },
                trailing: EditButton().foregroundColor(.red))
                
                .navigationBarTitle("Checklist")
                .onAppear() {
                    self.checklist.printChecklistContents()
                    self.checklist.saveListItems()
                }
            }
            .sheet(isPresented: $newChecklistItemViewIsVisible) {
                NewChecklistItemView(checklist: self.checklist)
            }
        }
    }
    
    
    //  Methods
    //  =======
    func getCurrentDate() -> String {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: calendarManager.selectedDate)
        
    }
    
}


//  Preview
//  =======
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
