//
//  SwiftUIView.swift
//  UIKitDemoProgrammatically
//
//  Created by Claudio Villanueva on 31-03-26.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var uikitText = "UIKit sample text"
    @State private var swiftuiText = "SwiftUI sample text"
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("This is a SwiftUI Screen ;)")
                .labelStyle(.titleAndIcon)
                .padding()
                .background(.yellow)
            TextField("", text: $swiftuiText)
                .textFieldStyle(.roundedBorder)
                .padding()
            UIKitTextField(text: $uikitText)
                .frame(maxHeight: 44)
                .padding()

            Button {
                debugPrint("SwiftUI button taaped, text:\(uikitText)")
            } label: {
                Text("SwiftUI Button")
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            
            UIKitButton(title: "UIKit Button", action: {
                debugPrint("UIKitButton taaped, text:\(uikitText)")
            })
            .frame(maxHeight: 44)
            .padding()
            
            Spacer()
        }
        .background(.cyan.opacity(0.3))
    }
}

#Preview {
    SwiftUIView()
}
