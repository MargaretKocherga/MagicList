//
//  EditProfileView.swift
//  Checklist
//
//  Created by Margo on 12.12.20.
//

import SwiftUI

struct EditProfileView: View {
    
    //  Properties
    //  ==========
    @Binding var user: User
    @State var isShowPhotoLibrary = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var isNotInitialised: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: 10)
                Button(action: {
                    self.isNotInitialised = false
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
                .frame(width: max(0, geometry.size.width - 30), height: 20, alignment: .trailing)
                .accentColor(.red)
                .disabled(user.name.count == 0)
                
                if(user.photo != nil) {
                    Image(uiImage: UIImage(data: user.photo!)!)
                        .resizable()
                        .frame(width: 132,height:132)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 132,height:132)
                        .clipShape(Circle())
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    self.isShowPhotoLibrary = true
                }) {
                    HStack {
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                        Text("Change photo")
                            .font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color(.systemRed))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .padding(.horizontal)
                }
                
                Form {
                    TextField("Name", text: $user.name)
                }
                .accentColor(.red)
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(user: self.$user, sourceType: .photoLibrary)
            }
        }
    }
}

//  Previews
//  ========
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: .constant(User()), isNotInitialised: .constant(Bool()))
    }
}
