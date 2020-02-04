//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var animationStyle: String?
    
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 10
        return buttonStack
    }()
    lazy var upButton: UIButton = {
        let button = UIButton()
        button.setTitle("Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var downButton: UIButton = {
        let button = UIButton()
        button.setTitle("Down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(animateSquareLeft(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Right", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(animateSquareRight(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var animationTimeStepper: UIStepper = {
        let step = UIStepper()
        step.maximumValue = 5
        step.minimumValue = 0
        step.stepValue = 1
        step.addTarget(self, action: #selector(animateStepperPressed(sender:)), for: .touchUpInside)
        return step
    }()
    lazy var animationTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "duration"
        label.textAlignment = .center
        return label
    }()
    lazy var distanceStepper: UIStepper = {
        let step = UIStepper()
        step.maximumValue = 100
        step.minimumValue = 10
        step.stepValue = 10
        step.addTarget(self, action: #selector(distanceStepperPressed(sender:)), for: .touchUpInside)
        return step
    }()
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "distance"
        label.textAlignment = .center
        return label
    }()
    
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .white
        configureNavBar()
        configureConstraints()
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(showSettings(_:)))
    }
    
    @objc
    private func showSettings(_ sender: UIBarButtonItem) {
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - CGFloat(distanceStepper.value)
        if animationStyle != nil {
            animationStylePicked(style: animationStyle ?? "curveEaseIn")
        } else {
            UIView.animate(withDuration: animationTimeStepper.value) { [unowned self] in
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset + CGFloat(distanceStepper.value)
        if animationStyle != nil {
            animationStylePicked(style: animationStyle ?? "curveEaseIn")
        } else {
            UIView.animate(withDuration: animationTimeStepper.value) { [unowned self] in
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func animateSquareLeft(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset - CGFloat(distanceStepper.value)
        if animationStyle != nil {
            animationStylePicked(style: animationStyle ?? "curveEaseIn")
        } else {
            UIView.animate(withDuration: animationTimeStepper.value) { [unowned self] in
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func animateSquareRight(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset + CGFloat(distanceStepper.value)
        if animationStyle != nil {
            animationStylePicked(style: animationStyle ?? "curveEaseIn")
        } else {
            UIView.animate(withDuration: animationTimeStepper.value) { [unowned self] in
                self.view.layoutIfNeeded()
            }
        }
    }
    @IBAction func animateStepperPressed(sender: UIStepper) {
        sender.value = animationTimeStepper.value
        animationTimeLabel.text = "duration: \(animationTimeStepper.value)"
    }
    @IBAction func distanceStepperPressed(sender: UIStepper) {
        sender.value = distanceStepper.value
        distanceLabel.text = "distance: \(distanceStepper.value)"
    }
    private func animationStylePicked(style: String) {
        if style == "transitionFlipFromLeft" {
            if blueSquare.backgroundColor == .blue {
                UIView.transition(with: blueSquare, duration: animationTimeStepper.value, options: [.transitionFlipFromLeft], animations: {
                    self.blueSquare.backgroundColor = .systemPink
                }, completion: nil)
            } else {
              UIView.transition(with: blueSquare, duration: animationTimeStepper.value, options: [.transitionFlipFromLeft], animations: {
                    self.blueSquare.backgroundColor = .blue
                }, completion: nil)
            }
            
        } else if style == "transitionFlipFromRight" {
            if blueSquare.backgroundColor == .blue {
                UIView.transition(with: blueSquare, duration: animationTimeStepper.value, options: [.transitionFlipFromRight], animations: {
                    self.blueSquare.backgroundColor = .systemPink
                }, completion: nil)
            } else {
              UIView.transition(with: blueSquare, duration: animationTimeStepper.value, options: [.transitionFlipFromRight], animations: {
                    self.blueSquare.backgroundColor = .blue
                }, completion: nil)
            }
            
        } else if style == "repeat" {
            UIView.animate(withDuration: animationTimeStepper.value, delay: 0.0, options: .repeat, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonStackView)
    }
    
    private func addStackViewSubviews() {
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
        buttonStackView.addSubview(leftButton)
        buttonStackView.addSubview(rightButton)
    }
    
    private func configureConstraints() {
        constrainBlueSquare()
        constrainUpButton()
        constrainLeftButton()
        constrainRightButton()
        constrainDownButton()
        constrainButtonStackView()
        animationStepperConstraints()
        animationLabelConstraint()
        distanceStepperConstraints()
        distanceLabelConstraint()
    }
    
    private func animationStepperConstraints() {
        view.addSubview(animationTimeStepper)
        animationTimeStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationTimeStepper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            animationTimeStepper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func animationLabelConstraint() {
        view.addSubview(animationTimeLabel)
        animationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationTimeLabel.topAnchor.constraint(equalTo: animationTimeStepper.bottomAnchor, constant: 8),
            animationTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            animationTimeLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    private func distanceStepperConstraints() {
        view.addSubview(distanceStepper)
        distanceStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            distanceStepper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            distanceStepper.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func distanceLabelConstraint() {
        view.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: distanceStepper.bottomAnchor, constant: 8),
            distanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            distanceLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        upButton.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor, constant: 10).isActive = true
        upButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func constrainLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: upButton.trailingAnchor, constant: 10).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    private func constrainRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rightButton.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 10).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        downButton.leadingAnchor.constraint(equalTo: rightButton.trailingAnchor, constant: 10).isActive = true
        downButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    private func constrainButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}
extension ViewController: AnimationStyleDelegate {
    func didSelectAnimationStyle(style: AnimationStyle.RawValue) {
        animationStyle = style
        
    }
    
    
}
