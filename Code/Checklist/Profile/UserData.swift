//
//  UserData.swift
//  Checklist
//
//  Created by Margo on 12.12.20.
//

import Foundation

class UserData: ObservableObject {
    @Published var user = User()
    
    //  Methods
    //  =======
    init() {
        loadUser()
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("User.plist")
    }
    
    func saveUser() {
        //  1
        let encoder = PropertyListEncoder()
        //  2
        do {
            //  3
            let data = try encoder.encode(user)
            //  4
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
            //  5
        } catch {
            //  6
            print("Error encoding user: \(error.localizedDescription)")
        }
    }
    
    func loadUser() {
        //  1
        let path = dataFilePath()
        //  2
        if let data = try? Data(contentsOf: path) {
            //  3
            let decoder = PropertyListDecoder()
            do {
                //  4
                user = try decoder.decode(User.self, from: data)
                //  5
            } catch {
                print("Error decoding user: \(error.localizedDescription)")
            }
        }
    }
    
}
