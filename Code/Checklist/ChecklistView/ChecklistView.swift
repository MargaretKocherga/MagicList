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
    @State var selection: Int? = nil
    @ObservedObject var calendarManager = CalendarManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365))
    @ObservedObject var checklist = Checklist(selectedDate: Date())
    
    
    //  User interface content and layout
    //  =================================
    var body: some View {
        
        VStack {

            GeometryReader { geometry in
                NavigationView {
                    List {
                        ForEach(checklist.items) { index in
                            if(Calendar.current.compare(self.checklist.items[index].date, to: calendarManager.selectedDate,
                                                        toGranularity: .day) == .orderedSame) {
                                RowView(checklistItem: self.$checklist.items[index])
                            }
                        }
                        .onDelete(perform: checklist.deleteListItem)
                        .onMove(perform: checklist.moveListItem)
                    }
                    .navigationBarItems(leading:
                        HStack {
                            VStack {
                                Spacer(minLength: 10)
                                NavigationLink(destination: ProfileView(), tag: 2, selection: self.$selection) {
                                    Button(action: {
                                        self.selection = 2
                                    }) {
                                        Image(systemName: "person.crop.circle")
                                            .resizable()
                                            .frame(width: 25,  height: 25)
                                            
                                    }
                                }.padding(-5)
                                .padding(.leading, -(geometry.size.width / 8.5))
                                
                                
                                Button(action: {
                                    self.newChecklistItemViewIsVisible = true
                                }) {
                                    HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add item")
                                    }
                                }
                            }
                            Text(getCurrentDate()).padding(.leading, (geometry.size.width / 32.0))
                        }.foregroundColor(.red),
                    trailing:
                        VStack {
                            Spacer(minLength: 10)
                            Button(action: {
                                self.calendarIsVisible = true
                            }) {
                                Image(systemName: "calendar.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height:25)
                            }.padding(-5)
                            .sheet(isPresented: $calendarIsVisible, content: {
                                        CalendarViewController(isPresented: self.$calendarIsVisible, calendarManager: self.calendarManager, checklist: self.checklist)})
                    
                            EditButton()
                            
                        }.foregroundColor(.red))
                    
                    .navigationBarTitle("\nChecklist")
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
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
        
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
