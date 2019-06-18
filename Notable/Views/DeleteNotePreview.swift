//
//  DeleteNotePreview.swift
//  Notable
//
//  Created by Christopher Thiebaut on 6/14/19.
//  Copyright © 2019 Christopher Thiebaut. All rights reserved.
//

import SwiftUI
import Combine

struct DeleteNotePreview : View {
    @State var note: Note
    @EnvironmentObject var noteRepository: NoteRepository
    let cancelBox = CancelBox()
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                self.note.title = ""
                self.note.content = ""
            }) {
                Text("Delete")
                    .color(.white)
                }
                .padding(.horizontal)
                .background(Color.red)
                .cornerRadius(15)
            NotePreview(note: note)
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            let cancellable = self.note.didChange.sink { note in
                self.noteRepository.update(with: note)
            }
            self.cancelBox.cancellables.append(cancellable)
        }
    }
    
    class CancelBox {
        var cancellables = [Cancellable]()
    }
}

#if DEBUG
struct DeleteNotePreview_Previews : PreviewProvider {
    static var previews: some View {
        DeleteNotePreview(note: Note(title: "Endangered", content: "Note"))
            .environmentObject(NoteRepository())

    }
}
#endif
