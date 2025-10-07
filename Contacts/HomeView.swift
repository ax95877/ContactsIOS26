//
//  HomeView.swift
//  Contacts
//
//  Created by Alex on 2025-10-06.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Tab("Contacts",systemImage: "person.crop.circle.fill"){
                ContactsView()
            }
            Tab("Calls",systemImage: "clock.fill"){
                CallsView()
            }
            Tab("Keyboard",systemImage: "keyboard"){
                KeyboardView()
            }
            Tab("Add",systemImage: "plus", role:.search){
                EmptyView()
            }
        }
    }
}

#Preview {
    HomeView()
}
