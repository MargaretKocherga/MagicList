//
//  RowView.swift
//  Checklist
//
//  Created by Margo on 10/6/20.
//

import SwiftUI

struct RowView: View {
    
    //  Properties
    //  ==========
    @Binding var checklistItem: ChecklistItem
    
    var body: some View {
        NavigationLink(destination:
                        EditChecklistItemView(checklistItem: $checklistItem)) {
            HStack {
                Text(checklistItem.isChecked ? "✅" : "🔲")
                Text(checklistItem.name)
                Spacer()
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(checklistItem: .constant(ChecklistItem(name: "Sample item")))
    }
}
