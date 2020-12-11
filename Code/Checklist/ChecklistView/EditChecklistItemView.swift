//
//  EditChecklistItemView.swift
//  Checklist
//
//  Created by Margo on 10/5/20.
//

import SwiftUI

struct EditChecklistItemView: View {
    
    //  Properties
    //  ==========
    @Binding var checklistItem: ChecklistItem
    
    var body: some View {
        Form {
            TextField("Name", text: $checklistItem.name)
            DatePicker("Date", selection: $checklistItem.date, displayedComponents: .date)
            Toggle("Completed", isOn: $checklistItem.isChecked)
        }
        .accentColor(.red)
    }
}

struct EditChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditChecklistItemView(checklistItem: .constant(ChecklistItem(name: "Sample item", date: Date())))
    }
}
