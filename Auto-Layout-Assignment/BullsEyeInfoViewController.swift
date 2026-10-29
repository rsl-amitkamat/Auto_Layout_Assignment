//
//  BullsEyeInfoViewController.swift
//  Auto-Layout-Assignment
//
//  Created by Amit Kamat on 29/10/26.
//


import UIKit

class BullsEyeInfoViewController: UIViewController {

    private let scores: [Int]
    private let totalScore: Int
    private let roundsPlayed: Int

    init(scores: [Int], totalScore: Int, roundsPlayed: Int) {
        self.scores = scores
        self.totalScore = totalScore
        self.roundsPlayed = roundsPlayed
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Round Scores"
        view.backgroundColor = .systemBackground

        let detailsLabel = UILabel()
        detailsLabel.numberOfLines = 0
        detailsLabel.font = .systemFont(ofSize: 18)

        let history = scores.enumerated().map { index, score in
            "Round \(index + 1): \(score) points"
        }.joined(separator: "\n")

        detailsLabel.text = """
        Rounds Played: \(roundsPlayed)
        Total Score: \(totalScore)

        \(history.isEmpty ? "No rounds played yet." : history)
        """

        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailsLabel)

        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            detailsLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            detailsLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            )
        ])
    }
}
