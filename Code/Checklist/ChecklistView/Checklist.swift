//
//  Checklist.swift
//  Checklist
//
//  Created by Margo on 10/2/20.
//

import Foundation

class Checklist: ObservableObject {
    @Published var items: [ChecklistItem] = []
    public var selectedDate: Date!
    
    //  Methods
    //  =======
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
        print("Documents directory is: \(documentsDirectory())")
        print("Data file path is: \(dataFilePath())")
        loadListItems()
    }
    
    func printChecklistContents() {
        for item in items {
            if(Calendar.current.compare(item.date, to: selectedDate, toGranularity: .day) == .orderedSame) {
                print(item)
            }
        }
    }
    
    func deleteListItem(whichElement: IndexSet) {
        items.remove(atOffsets: whichElement)
        printChecklistContents()
        saveListItems()
    }
    
    func moveListItem(whichElement: IndexSet, destination: Int) {
        items.move(fromOffsets: whichElement, toOffset: destination)
        printChecklistContents()
        saveListItems()
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklist.plist")
    }
    
    func saveListItems() {
        //  1
        let encoder = PropertyListEncoder()
        //  2
        do {
            //  3
            let data = try encoder.encode(items)
            //  4
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
            //  5
        } catch {
            //  6
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    func loadListItems() {
        //  1
        let path = dataFilePath()
        //  2
        if let data = try? Data(contentsOf: path) {
            //  3
            let decoder = PropertyListDecoder()
            do {
                //  4
//                var bufItems: [ChecklistItem] = []
                items = try decoder.decode([ChecklistItem].self, from: data)
//                for item in bufItems {
//                    if(Calendar.current.compare(item.date, to: selectedDate, toGranularity: .day) == .orderedSame) {
//                        items.append(item)
//                    }
//                }
                //  5
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
}
