//
//  HomwView.swift
//  NotesSwiftUI
//
//  Created by Luis Enrique Rosas Espinoza on 22/04/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)]) var results: FetchedResults<Notes>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(results) { item in
                    VStack(alignment: .leading) {
                        Text(item.note ?? "Not note")
                            .fontWeight(.bold)
                        Text(item.date ?? Date(), style: .date)
                            .fontWeight(.light)
                    }
                    .contextMenu {
                        Button {
                            viewModel.sendItem(item: item)
                        } label: {
                            Label(title: {
                                Text("Edit")
                                     }, icon: {
                                    Image(systemName: "pencil")
                                }
                            )
                        }
                        Button {
                            viewModel.deleteData(item: item, context: context)
                        } label: {
                            Label(title: {
                                Text("Delete")
                                     }, icon: {
                                    Image(systemName: "trash")
                                }
                            )
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button(action: {
                        viewModel.show.toggle()
                    }) {
                        Label("Agregar", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.show) {
                AddNoteView()
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewModel())
    }
}
