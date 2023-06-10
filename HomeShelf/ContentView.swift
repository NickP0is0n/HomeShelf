//
//  ContentView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 08.06.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) private var viewContext
   
    var body: some View {
        NavigationView {
            List {
                Text("Library")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Group {
                    NavigationLink(destination: AllBooksView()
                        .environment(\.managedObjectContext, manager.container.viewContext)) {
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
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Group {
                    NavigationLink(destination: ContentView()) {
                        Label("Favorites", systemImage: "star")
                    }
                    NavigationLink(destination: ContentView()) {
                        Label("New list", systemImage: "plus")
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 150, idealWidth: 250, maxWidth: 300)
            .toolbar {
                ToolbarItem(placement: .navigation){
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.left")
                    })
                    }
                }
            AllBooksView()
        }
    }
}

func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
