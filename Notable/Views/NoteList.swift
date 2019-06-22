//
//  NoteList.swift
//  Notable
//
//  Created by Christopher Thiebaut on 6/12/19.
//  Copyright © 2019 Christopher Thiebaut. All rights reserved.
//

import SwiftUI

struct NoteList : View {
    
    @EnvironmentObject var noteRepository: NoteRepository
    
    @State var isEditing: Bool
    
    var body: some View {
        NavigationView {
            Group {
                HStack(alignment: .top) {
                    Spacer()
                    NavigationButton(destination: NoteEditingView(note: Note(title: "", content: "")), isDetail: false) {
                        Text("New")
                    }
                }
                .padding(.horizontal)

                List(noteRepository.notes) { note in
                    if self.isEditing {
                        DeleteNotePreview(note: note)
                            .animation(.basic())
                    } else {
                        NavigationButton(
                        destination: NoteEditingView(note: note)) {
                            NotePreview(note: note)
                        }
                        .animation(.basic())
                        
                    }
                    
                }
            }
            .navigationBarTitle(Text("Notes"))
            .navigationBarItems(trailing: Button(
                action: { self.isEditing.toggle() },
                label: {
                    if self.isEditing {
                        Text("Done").bold()
                    } else {
                        Text("Edit")
                    }
                }))
        }
    }
}

#if DEBUG
struct NoteList_Previews : PreviewProvider {
    static var demoNotes: [Note] {
        let note1 = Note(title: "First!", content: "This is the first note (best note)")
        let note2 = Note(title: "First the worst", content: "Second the best")
        let last = Note(title: "Last", content: "But not least 😉")
        return [note1, note2, last]
    }
    static var previews: some View {
        Group {
            NoteList(isEditing: true)
                .environmentObject(NoteRepository(store: FakeNoteStore(notes: demoNotes)))
            
            NoteList(isEditing: false)
                .environmentObject(NoteRepository(store: FakeNoteStore(notes: demoNotes)))
        }

    }
}
#endif
