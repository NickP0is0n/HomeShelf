//
//  ContentView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 08.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Library")
                Group {
                    NavigationLink(destination: ContentView()) {
                        Label("All", systemImage: "book")
                    }
                    NavigationLink(destination: ContentView()) {
                        Label("Want to read", systemImage: "bookmark")
                    }
                    NavigationLink(destination: ContentView()) {
                        Label("In process", systemImage: "arrow.right.circle")
                    }
                    NavigationLink(destination: ContentView()) {
                        Label("Finished", systemImage: "book.closed.circle")
                    }
                    NavigationLink(destination: ContentView()) {
                        Label("Loaned", systemImage: "person.badge.clock")
                    }
                }
                Spacer()
                Text("Your lists")
                Group {
                    NavigationLink(destination: ContentView()) {
                        Label("Favorites", systemImage: "star")
                    }
                    NavigationLink(destination: ContentView()) {
                        Label("New list", systemImage: "plus")
                    }
                }
            }.listStyle(SidebarListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
