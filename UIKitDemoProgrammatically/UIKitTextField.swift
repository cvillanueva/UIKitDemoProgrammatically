//
//  TextFieldWrapper.swift
//  UIKitDemoProgrammatically
//
//  Created by Claudio Villanueva on 31-03-26.
//

import SwiftUI
import UIKit

struct UIKitTextField: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UIKitTextField
        
        init(parent: UIKitTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            // UI updates have to run in the main thread
            DispatchQueue.main.async {
                self.parent.text = textField.text ?? ""
            }
        }
        
        @objc func clearAction() {
            debugPrint("clearing text")
            parent.$text.wrappedValue = ""
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        // Customizing Style
        textField.delegate = context.coordinator
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 20.0
        textField.layer.borderColor = UIColor.purple.cgColor
        textField.layer.borderWidth = 1.0
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 44))
        textField.leftViewMode = .always
        
        let button = UIButton(type: .custom)

        if let image = UIImage(systemName: "xmark.circle.fill")  {
            button.setImage(
                image.resized(to: CGSize(width: 36, height: 36)).withTintColor(.purple),
                for: .normal
            )
        }
        
        // Define action
        button.addAction(UIAction(title: "", handler: { action in
            context.coordinator.clearAction()
        }), for: .touchUpInside)
        
        textField.rightView = button
        textField.rightViewMode = .always
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}

extension UIImage {
    /// Resizes the image to a new size.
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
