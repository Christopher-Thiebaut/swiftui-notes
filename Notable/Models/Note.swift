//
//  Note.swift
//  Notable
//
//  Created by Christopher Thiebaut on 6/12/19.
//  Copyright © 2019 Christopher Thiebaut. All rights reserved.
//

import Combine
import SwiftUI

final class Note: BindableObject, Identifiable, Codable {
    
    var didChange = PassthroughSubject<Note, Never>()
    
    var title: String {
        didSet {
            didChange.send(self)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case content
    }
    
    var content: String {
        didSet {
            didChange.send(self)
        }
    }
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
    }
}

extension Note {
    var isEmpty: Bool {
        return title.isEmpty && content.isEmpty
    }
}
