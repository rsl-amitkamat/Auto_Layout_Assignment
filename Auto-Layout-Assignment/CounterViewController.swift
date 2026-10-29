//
//  CounterViewController.swift
//  Auto-Layout-Assignment
//
//  Created by Amit Kamat on 29/10/26.
//


import UIKit

class CounterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Custom Counter"
        view.backgroundColor = .systemBackground

        let counterView = CounterView()
        counterView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(counterView)

        NSLayoutConstraint.activate([
            counterView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            counterView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            counterView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            )
        ])
    }
}
