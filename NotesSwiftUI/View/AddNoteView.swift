//
//  AddNoteView.swift
//  NotesSwiftUI
//
//  Created by Luis Enrique Rosas Espinoza on 22/04/23.
//

import SwiftUI

struct AddNoteView: View {
    @ObservedObject var viewModel : ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            Text(viewModel.updateItem != nil ? "Edit Note" : "Add Note")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            TextEditor(text: $viewModel.note)
            Divider()
            DatePicker("Select Date:", selection: $viewModel.date)
            Spacer()
            Button {
                if viewModel.updateItem != nil {
                    viewModel.editData(context: context)
                } else {
                    viewModel.saveData(context: context)
                }
            } label: {
                Label {
                    Text("Save")
                } icon: {
                    Image(systemName: "square.and.arrow.down")
                }

            }
            .padding()
            .disabled(viewModel.note.isEmpty ? true : false)

        }
        .padding()
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(viewModel: ViewModel())
    }
}
