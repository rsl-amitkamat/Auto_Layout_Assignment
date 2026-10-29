//
//  CounterView.swift
//  Auto-Layout-Assignment
//
//  Created by Amit Kamat on 29/10/26.
//


import UIKit

class CounterView: UIView, UIGestureRecognizerDelegate {

    private var count = 0

    private let imageView = UIImageView()
    private let countLabel = UILabel()
    private let incrementButton = UIButton(type: .system)
    private let enableSwitch = UISwitch()
    private let opacitySlider = UISlider()
    private let switchLabel = UILabel()
    private let sliderLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        updateCount()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        layer.cornerRadius = 16
        clipsToBounds = true

        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit

        countLabel.font = .systemFont(ofSize: 28, weight: .bold)
        countLabel.textAlignment = .center

        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.titleLabel?.font = .systemFont(ofSize: 18)
        incrementButton.addTarget(
            self,
            action: #selector(incrementCount),
            for: .touchUpInside
        )

        switchLabel.text = "Enable Increment"
        switchLabel.font = .systemFont(ofSize: 16)

        enableSwitch.isOn = true
        enableSwitch.addTarget(
            self,
            action: #selector(toggleIncrement),
            for: .valueChanged
        )

        sliderLabel.text = "Image Opacity"
        sliderLabel.font = .systemFont(ofSize: 16)

        opacitySlider.minimumValue = 0
        opacitySlider.maximumValue = 1
        opacitySlider.value = 1
        opacitySlider.addTarget(
            self,
            action: #selector(changeOpacity),
            for: .valueChanged
        )

        let switchRow = UIStackView(
            arrangedSubviews: [switchLabel, enableSwitch]
        )
        switchRow.axis = .horizontal
        switchRow.alignment = .center
        switchRow.distribution = .equalSpacing

        let sliderStack = UIStackView(
            arrangedSubviews: [sliderLabel, opacitySlider]
        )
        sliderStack.axis = .vertical
        sliderStack.spacing = 8

        let stack = UIStackView(
            arrangedSubviews: [
                imageView,
                countLabel,
                incrementButton,
                switchRow,
                sliderStack
            ]
        )
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 24
            ),
            stack.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            stack.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
            stack.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -24
            ),

            imageView.heightAnchor.constraint(equalToConstant: 100),
            incrementButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(decrementCount)
        )
        tap.delegate = self
        addGestureRecognizer(tap)
    }

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        let touchedView = touch.view

        if touchedView is UIControl || touchedView is UIImageView
            || touchedView is UILabel {
            return false
        }

        return true
    }

    @objc private func incrementCount() {
        guard enableSwitch.isOn else { return }
        count += 1
        updateCount()
    }

    @objc private func decrementCount() {
        count -= 1
        updateCount()
    }

    @objc private func toggleIncrement() {
        incrementButton.isEnabled = enableSwitch.isOn
        incrementButton.alpha = enableSwitch.isOn ? 1.0 : 0.4
    }

    @objc private func changeOpacity() {
        imageView.alpha = CGFloat(opacitySlider.value)
    }

    private func updateCount() {
        countLabel.text = "Count: \(count)"

        if count > 0 {
            backgroundColor = .systemGreen
        } else if count < 0 {
            backgroundColor = .systemRed
        } else {
            backgroundColor = .white
        }
    }
}
