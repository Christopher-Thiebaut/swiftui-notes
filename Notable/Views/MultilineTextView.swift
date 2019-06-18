//
//  MultilineTextView.swift
//  Notable
//
//  Created by Christopher Thiebaut on 6/13/19.
//  Copyright © 2019 Christopher Thiebaut. All rights reserved.
//

import SwiftUI
import Combine

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        
    }
    
    func makeCoordinator() -> MultilineTextView.Coordinator {
        return Coordinator($text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        @Binding var text: String
        
        init(_ text: Binding<String>) {
            $text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text ?? ""
        }
    }
}


#if DEBUG
struct MultilineTextView_Previews : PreviewProvider {
    static var previews: some View {
        MultilineTextView(text: .constant(
            "Long text goes here. It is very long.  Actually, it doesn't need to be all that long.  It just needed to exceed one line."))
    }
}
#endif
