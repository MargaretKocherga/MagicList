//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Margo on 10/2/20.
//

import Foundation

struct ChecklistItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var isChecked: Bool = false
}
