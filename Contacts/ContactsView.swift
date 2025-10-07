//
//  ContactsView.swift
//  Contacts
//
//  Created by Alex on 2025-10-06.
//

import SwiftUI

struct Contact: Identifiable{
    let id=UUID()
    let name:String
    let phoneNumber:String
    let email:String
    let initial:String
    let color:Color
    
    static let sampleContacts=[
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue),
        Contact(name: "Emily Johnson", phoneNumber: "+1 (555) 123-4567", email: "emily.j@email.com", initial: "EJ", color: .blue)
    ]
}

struct ContactsView: View {
    @State private var contacts=Contact.sampleContacts
    @State private var searchText=""
    
    var filteredContacts:[Contact]{
        if searchText.isEmpty{
            return contacts
        } else{
            return contacts.filter{ contact in
                contact.name.localizedCaseInsensitiveContains(searchText) ||
                contact.phoneNumber.contains(searchText)
            }
        }
    }
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [
                    Color.red.opacity(0.25),
                    Color.blue.opacity(0.25),
                    Color.cyan.opacity(0.25),
                    Color.mint.opacity(0.25),
                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                VStack{
                    // Saerch bar
                    SearchBar(text:$searchText)
                        .padding(.top,8)
                    // Contacts List View
                    ScrollView{
                        LazyVStack(spacing:0){
                            ForEach(filteredContacts){ contact in
                                NavigationLink{
                                    // Contact Details View
                                    ContactDetailView(contact:contact)
                                } label: {
                                    ContactRow(contact:contact)
                                }
                            }
                        }
                        .padding(.top,8)
                    }
                }
            }
            .navigationTitle("Contacts")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
struct ContactRow:View{
    let contact:Contact
    var body: some View{
        HStack{
            // Avatar
            ZStack{
                Circle()
                    .fill(
                        LinearGradient(colors: [
                            contact.color.opacity(0.8),
                            contact.color
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width:50, height:50)
                Text(contact.initial)
                    .font(.system(size: 18,weight: .semibold, design:.rounded))
                    .foregroundColor(.white)
            }
            .shadow(color:contact.color,radius: 4, x:0,y:2)
            
            //Name & Phone Number
            VStack {
                Text(contact.name)
                    .font(.system(size:17,weight: .medium))
                    .foregroundColor(.primary)
                Text(contact.phoneNumber)
                    .font(.system(size:15))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size:14,weight: .medium))
                .foregroundColor(Color(.tertiaryLabel))
        }
        .padding(.horizontal,20)
        .padding(.vertical,12)
    }
}
struct SearchBar:View{
    @Binding var text:String
    @State private var isEditing=false
    var body:some View{
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.system(size:16, weight:.medium))
                TextField("Search contacts", text:$text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isEditing=true
                        }
                    }
                
            }
        }
    }
    
}

#Preview {
    ContactsView()
}
