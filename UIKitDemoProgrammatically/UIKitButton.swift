//
//  UIKitButton.swift
//  UIKitDemoProgrammatically
//
//  Created by Claudio Villanueva on 31-03-26.
//

import SwiftUI
import UIKit

struct UIKitButton: UIViewRepresentable {
    // 1. Define the type of UIView this struct represents
    typealias UIViewType = UIButton
    
    // 2. A closure property to hold the action that will be executed when the button is tapped
    var title: String
    let action: () -> Void
    var configuration: (UIButton) -> Void = { _ in }

    // 3. Create and configure the initial UIButton instance
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .system)
        // Add the coordinator as a target for the .touchUpInside event
        button.addTarget(context.coordinator, action: #selector(Coordinator.didTap), for: .touchUpInside)
        configuration(button)
        button.setTitle(title, for: .normal)
        button.configuration = getConfiguration()
        return button
    }

    // 4. Update the view when SwiftUI state changes
    func updateUIView(_ uiView: UIButton, context: Context) {
        configuration(uiView)
    }
    
    // 5. Create a Coordinator to handle the button's event
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Define the Coordinator class as an internal class of the struct
    class Coordinator: NSObject {
        var parent: UIKitButton

        init(_ parent: UIKitButton) {
            self.parent = parent
        }
        
        // This method is called when the button is tapped
        @objc func didTap() {
            parent.action()
        }
    }
}

// Customizing Style
extension UIKitButton {
    func getConfiguration() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "star.fill")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.baseBackgroundColor = .systemBlue
        configuration.cornerStyle = .capsule
        return configuration
    }
}
