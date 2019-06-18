//
//  GeometryTextField.swift
//  Notable
//
//  Created by Christopher Thiebaut on 6/13/19.
//  Copyright © 2019 Christopher Thiebaut. All rights reserved.
//

import SwiftUI

struct GeometryTextField : View {
    @Binding var text: String
    
    var body: some View {
        GeometryReader { geometry in
            MultilineTextView(text: self.$text)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#if DEBUG
struct GeometryTextField_Previews : PreviewProvider {
    static var previews: some View {
        GeometryTextField(text:
            .constant("test that is long enough to cause a line break is tedious to type.  Is this long enough yet?"))
    }
}
#endif
