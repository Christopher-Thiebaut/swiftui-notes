//
//  NoteRepository.swift
//  Notable
//
//  Created by Christopher Thiebaut on 6/12/19.
//  Copyright © 2019 Christopher Thiebaut. All rights reserved.
//

import SwiftUI
import Combine

protocol NoteStore {
    func getNotes() -> [Note]
    func saveNotes(_ notes: [Note])
}

final class NoteRepository: BindableObject {

    var store: NoteStore {
        didSet {
            refreshFromStore()
        }
    }
    
    private(set) var notes: [Note]  = [] {
        didSet {
            store.saveNotes(notes)
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<NoteRepository, Never>()
    
    init(store: NoteStore) {
        self.store = store
        refreshFromStore()
    }
    
    convenience init() {
        let localStore = CodableNoteStore()
        self.init(store: localStore)
    }
    
    private func refreshFromStore() {
        notes = store.getNotes()
    }
    
    func update(with note: Note) {
        guard !note.isEmpty else { return delete(note: note) }
        if let indexToReplace = notes.firstIndex(where: { $0.id == note.id }) {
            notes[indexToReplace] = note
        } else {
            notes.insert(note, at: 0)
        }
    }
    
    func delete(note: Note) {
        guard let indexToDelete = notes.firstIndex(where: { $0.id == note.id }) else { return }
        notes.remove(at: indexToDelete)
    }
}

class CodableNoteStore: NoteStore {
    
    private let storeName = "CodableNoteStoreLocation"
    
    private var path: URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return URL(fileURLWithPath: "")
        }
        return url.appendingPathComponent(storeName)
    }
    
    func getNotes() -> [Note] {
        var notes: [Note]
        do {
            let data = try Data(contentsOf: path)
            notes = try JSONDecoder().decode([Note].self, from: data)
        } catch let error {
            NSLog("Failed to load notes due to an error: \(error)")
            notes = []
        }
        return notes
    }
    
    func saveNotes(_ notes: [Note]) {
        do {
            let data = try JSONEncoder().encode(notes)
            try data.write(to: path)
        } catch let error {
            NSLog("Failed to save notes due to an error: \(error)")
        }
    }
}

#if DEBUG
class FakeNoteStore: NoteStore {
    
    var notes: [Note]
    
    init(notes: [Note]) {
        self.notes = notes
    }
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func saveNotes(_ notes: [Note]) {
        self.notes = notes
    }
}
#endif
