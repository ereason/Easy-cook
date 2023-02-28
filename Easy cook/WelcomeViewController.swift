//
//  WelcomeViewController.swift
//  Easy cook
//
//  Created by Sergey Azimov on 27.02.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let welcomeView = WelcomeView()
    
    private  let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .poppinsBold16()
        button.setTitle("Get started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        return button
    }()
    
    
    override func loadView() {
        view = welcomeView
        view.addSubview(getStartedButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        setConstraints()
    }
    
    @objc private func buttonTapped(button: UIButton) {
         //let mainVC = ...
         //mainVC.modalPresentationStyle = .fullScreen
        //present(mainVC, animated: true)
    }
    
}

//MARK: - SetConstraints

extension WelcomeViewController {
   private func setConstraints() {
        NSLayoutConstraint.activate([
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            getStartedButton.widthAnchor.constraint(equalToConstant: 150),
            getStartedButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
}
