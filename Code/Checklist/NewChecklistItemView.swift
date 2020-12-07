//
//  NewChecklistItemView.swift
//  Checklist
//
//  Created by Margo on 10/5/20.
//

import SwiftUI

struct NewChecklistItemView: View {
    
    //  Properties
    //  ==========
    @State var newItemName = ""
    @Environment(\.presentationMode) var presentationMode
    var checklist: Checklist
    
    var body: some View {
        VStack {
            Text("Add new item")
            Form {
                TextField("Enter item name", text: $newItemName)
                Button(action: {
                    let newChecklistItem = ChecklistItem(name: newItemName)
                    self.checklist.items.append(newChecklistItem)
                    self.checklist.printChecklistContents()
                    self.checklist.saveListItems()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add new item")
                    }
                    .accentColor(.red)
                }
                .disabled(newItemName.count == 0)
            }
            Text("Swipe down to cancel")
        }
    }
}

struct NewChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewChecklistItemView(checklist: Checklist())
    }
}
