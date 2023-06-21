//
//  ContentView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 08.06.2023.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) private var userListEntities: FetchedResults<UserListEntity>
    @State var newListSheetActivated = false
   
    var body: some View {
        NavigationView {
            List {
                Text("Library")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Group {
                    NavigationLink(destination: AllBooksView()
                        .background(.background)) {
                        Label("All", systemImage: "book")
                    }
                    NavigationLink(destination: WantToReadView()
                        .background(.background)) {
                        Label("Want to read", systemImage: "bookmark")
                    }
                    NavigationLink(destination: InProgressView()
                        .background(.background)) {
                        Label("In process", systemImage: "arrow.right.circle")
                    }
                    NavigationLink(destination: FinishedBooksView()
                        .background(.background)) {
                        Label("Finished", systemImage: "book.closed.circle")
                    }
                    NavigationLink(destination: LoanedBooksListView()
                        .background(.background)) {
                        Label("Loaned", systemImage: "person.badge.clock")
                    }
                }
                Spacer()
                Text("Your lists")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Group {
                    NavigationLink(destination: FavoriteBooksView()
                        .background(.background)) {
                        Label("Favorite books", systemImage: "star")
                    }
                    ForEach(userListEntities) { userList in
                        NavigationLink(destination: UserListView(listName: userList.listName)
                            .background(.background)) {
                            Label(userList.listName, systemImage: "list.bullet")
                        }
                    }
                    NavigationLink(destination: AllBooksView()
                        .background(.background)
                        .onAppear {
                            newListSheetActivated = true
                    }.sheet(isPresented: $newListSheetActivated) {
                        NewListView(isNewListSheetActivated: $newListSheetActivated)
                    }.background(.background)) {
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
                .background(.background)
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
