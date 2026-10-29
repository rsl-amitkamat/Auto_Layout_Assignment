//
//  MainViewController.swift
//  Auto-Layout-Assignment
//
//  Created by Amit Kamat on 29/10/26.
//


import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "UIView & UIControl"
        view.backgroundColor = .systemBackground

        let counterButton = UIButton(type: .system)
        counterButton.setTitle("Assignment 1 - Custom Counter", for: .normal)

        let gameButton = UIButton(type: .system)
        gameButton.setTitle("Assignment 2 - Bull's Eye", for: .normal)

        counterButton.addTarget(
            self,
            action: #selector(openCounter),
            for: .touchUpInside
        )

        gameButton.addTarget(
            self,
            action: #selector(openGame),
            for: .touchUpInside
        )

        let stack = UIStackView(
            arrangedSubviews: [counterButton, gameButton]
        )
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            stack.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            stack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            stack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            )
        ])
    }

    @objc private func openCounter() {
        navigationController?.pushViewController(
            CounterViewController(),
            animated: true
        )
    }

    @objc private func openGame() {
        navigationController?.pushViewController(
            BullsEyeViewController(),
            animated: true
        )
    }
}
