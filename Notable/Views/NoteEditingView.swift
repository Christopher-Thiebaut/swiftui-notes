//
//  NoteEditingView.swift
//  Notable
//
//  Created by Christopher Thiebaut on 6/12/19.
//  Copyright © 2019 Christopher Thiebaut. All rights reserved.
//

import SwiftUI
import Combine

struct NoteEditingView : View {
    @State var note: Note
    
    @EnvironmentObject var repository: NoteRepository
    
    let cancelBox = CancelBox()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField(self.$note.title)
            GeometryTextField(text: self.$note.content)
            Spacer()
            .padding(.vertical)
        }
        .onAppear {
            let cancellable = self.note.didChange.sink { note in
                self.repository.update(with: self.note)
            }
            self.cancelBox.cancellables.append(cancellable)
        }
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(.leading)
        .padding(.horizontal)

    }
    
    class CancelBox {
        var cancellables = [Cancellable]()
    }
}

#if DEBUG
struct NoteEditingView_Previews : PreviewProvider {
    
    static let longNoteContent = #"This is a long string, I'm just going to keep typing forever.  Well, at least until it's a fail few lines. Whatever."#
    static var previews: some View {
        NavigationView {
            NoteEditingView(note: Note(title: "Title", content: longNoteContent))
                .environmentObject(NoteRepository())
        }
    }
}
#endif
