//
//  BullsEyeViewController.swift
//  Auto-Layout-Assignment
//
//  Created by Amit Kamat on 29/10/26.
//


import UIKit

class BullsEyeViewController: UIViewController {

    private var targetValue = Int.random(in: 1...100)
    private var totalScore = 0
    private var roundsPlayed = 0
    private var roundScores: [Int] = []

    private let targetLabel = UILabel()
    private let slider = UISlider()
    private let sliderValueLabel = UILabel()
    private let scoreLabel = UILabel()
    private let roundsLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Bull's Eye"
        view.backgroundColor = .systemBackground

        setupUI()
        updateLabels()
    }

    private func setupUI() {
        targetLabel.font = .systemFont(ofSize: 24, weight: .bold)
        targetLabel.textAlignment = .center
        targetLabel.numberOfLines = 0

        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = 50
        slider.addTarget(
            self,
            action: #selector(sliderChanged),
            for: .valueChanged
        )

        sliderValueLabel.textAlignment = .center
        sliderValueLabel.font = .systemFont(ofSize: 18)

        scoreLabel.textAlignment = .center
        scoreLabel.font = .systemFont(ofSize: 18, weight: .medium)

        roundsLabel.textAlignment = .center
        roundsLabel.font = .systemFont(ofSize: 16)

        let hitButton = UIButton(type: .system)
        hitButton.setTitle("Hit Me!", for: .normal)
        hitButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        hitButton.addTarget(
            self,
            action: #selector(hitMe),
            for: .touchUpInside
        )

        let infoButton = UIButton(type: .system)
        infoButton.setTitle("Info", for: .normal)
        infoButton.addTarget(
            self,
            action: #selector(showInfo),
            for: .touchUpInside
        )

        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Start Over", for: .normal)
        resetButton.addTarget(
            self,
            action: #selector(startOver),
            for: .touchUpInside
        )

        let buttonRow = UIStackView(
            arrangedSubviews: [infoButton, hitButton, resetButton]
        )
        buttonRow.axis = .horizontal
        buttonRow.distribution = .fillEqually
        buttonRow.spacing = 12

        let stack = UIStackView(
            arrangedSubviews: [
                targetLabel,
                slider,
                sliderValueLabel,
                hitButton,
                scoreLabel,
                roundsLabel,
                buttonRow
            ]
        )
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
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
            ),
            hitButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    @objc private func sliderChanged() {
        sliderValueLabel.text = "Your guess: \(Int(slider.value.rounded()))"
    }

    @objc private func hitMe() {
        let guess = Int(slider.value.rounded())
        let difference = abs(targetValue - guess)
        let points = max(0, 100 - difference)

        roundsPlayed += 1
        totalScore += points
        roundScores.append(points)

        let alert = UIAlertController(
            title: "Round Score",
            message: """
            Target: \(targetValue)
            Your guess: \(guess)
            Difference: \(difference)
            Points earned: \(points)
            """,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Continue", style: .default) {
            [weak self] _ in
            self?.nextRound()
        })

        present(alert, animated: true)
        updateLabels()
    }

    private func nextRound() {
        targetValue = Int.random(in: 1...100)
        slider.value = 50
        updateLabels()
    }

    private func updateLabels() {
        targetLabel.text = "Move the slider to: \(targetValue)"
        sliderValueLabel.text =
            "Your guess: \(Int(slider.value.rounded()))"
        scoreLabel.text = "Total Score: \(totalScore)"
        roundsLabel.text = "Rounds Played: \(roundsPlayed)"
    }

    @objc private func showInfo() {
        let infoVC = BullsEyeInfoViewController(
            scores: roundScores,
            totalScore: totalScore,
            roundsPlayed: roundsPlayed
        )

        navigationController?.pushViewController(
            infoVC,
            animated: true
        )
    }

    @objc private func startOver() {
        let alert = UIAlertController(
            title: "Start Over?",
            message: "This will reset your score and round history.",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "Cancel", style: .cancel)
        )

        alert.addAction(
            UIAlertAction(title: "Reset", style: .destructive) {
                [weak self] _ in
                self?.resetGame()
            }
        )

        present(alert, animated: true)
    }

    private func resetGame() {
        targetValue = Int.random(in: 1...100)
        totalScore = 0
        roundsPlayed = 0
        roundScores.removeAll()
        slider.value = 50
        updateLabels()
    }
}
