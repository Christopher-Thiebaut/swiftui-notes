//
//  NotePreview.swift
//  Notable
//
//  Created by Christopher Thiebaut on 6/12/19.
//  Copyright © 2019 Christopher Thiebaut. All rights reserved.
//

import SwiftUI

struct NotePreview : View {
    @State var note: Note
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(note.title)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Text(note.content)
                .font(.footnote)
                .fontWeight(.light)
        }
        .padding(16)
    }
}

#if DEBUG
struct NotePreview_Previews : PreviewProvider {
    static let longNoteContent = #"This is a long string, I'm just going to keep typing forever.  Well, at least until it's a fail few lines. Whatever."#
    
    static var previews: some View {
        NotePreview(note: Note(title: "Title", content: longNoteContent))
    }
}
#endif
