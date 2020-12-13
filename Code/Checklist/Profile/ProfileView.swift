//
//  ProfileView.swift
//  Checklist
//
//  Created by Margo on 11.12.20.
//

import SwiftUI

struct ProfileView: View {
    
    //  Properties
    //  ==========
    @ObservedObject var userData = UserData()
    @State var isNotInitialised = true
    var body: some View {
        NavigationView {
            VStack {
                if(userData.user.photo != nil) {
                    Image(uiImage: UIImage(data: userData.user.photo!)!)
                        .resizable()
                        .frame(width: 132, height:132)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 132, height:132)
                        .clipShape(Circle())
                        .foregroundColor(.red)
                }
                Text(userData.user.name)
                    .font(.system(size: 24))
                    .bold()
                Spacer()
            }
            .sheet(isPresented: $isNotInitialised) {
                EditProfileView(user: $userData.user, isNotInitialised: $isNotInitialised)
            }
            .onAppear {
                isNotInitialised = userData.user.name.count == 0
                userData.saveUser()
            }
            .onDisappear {
                userData.saveUser()
            }
        
        }
        .navigationBarItems(trailing:
            Button(action: {
                self.isNotInitialised = true
            }) {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 25, height:25)
            })
        .foregroundColor(.red)
    }
    
}

//  Preview
//  =======
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
