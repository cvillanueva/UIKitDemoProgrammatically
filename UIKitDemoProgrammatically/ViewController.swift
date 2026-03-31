//
//  ViewController.swift
//  UIKitDemoProgrammatically
//
//  Created by Claudio Villanueva on 26-03-26.
//

import UIKit

class ViewController: UIViewController {

    private var stackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.axis = .vertical
        view.distribution = .fillEqually
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var viewOne = getView(color: .systemBrown)
    private lazy var viewTwo = getView(color: .systemCyan)
    private lazy var viewThree = getView(color: .systemPurple)

    private lazy var buttonOne = getButton(title: "Button 1", selector: #selector(buttonOneTapped(_:)))
    private lazy var buttonTwo = getButton(title: "Button 2", selector: #selector(buttonTwoTapped(_:)))
    private lazy var buttonThree = getButton(title: "Button 3", selector: #selector(buttonThreeTapped(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        debugPrint("ViewController viewDidLoad()")
        setViews()
    }
    
    @objc func buttonOneTapped(_ sender: UIButton) {
        debugPrint("Button 1 tapped")
    }
    
    @objc func buttonTwoTapped(_ sender: UIButton) {
        debugPrint("Button 2 tapped")
    }
    
    @objc func buttonThreeTapped(_ sender: UIButton) {
        debugPrint("Button 3 tapped")
    }
}

// Setting up the UI
extension ViewController {
    func setViews() {
        view.backgroundColor = .white
        
        // Adding views
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(viewOne) // UIStackView has its own method for adding views
        viewOne.addSubview(buttonOne)
        
        stackView.addArrangedSubview(viewTwo)
        viewTwo.addSubview(buttonTwo)
        
        stackView.addArrangedSubview(viewThree)
        viewThree.addSubview(buttonThree)
        
        // Setting up constraints
        // It is mandatory to set them once the widget has been added to the parent view.
        setStackViewContraints()
        setButtonConstraints(button: buttonOne, parentView: viewOne)
        setButtonConstraints(button: buttonTwo, parentView: viewTwo)
        setButtonConstraints(button: buttonThree, parentView: viewThree)
    }
    
    private func setStackViewContraints() {
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setButtonConstraints(button: UIButton, parentView: UIView) {
        button.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 48.0).isActive = true
        button.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -48.0).isActive = true
        button.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 48.0).isActive = true
        button.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -48.0).isActive = true
    }
}

// UI Factory functions
extension ViewController {
    func getView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
    
    func getButton(title: String, selector: Selector) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = .systemBlue
        
        let button = UIButton()
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.tintColor = .white
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}
