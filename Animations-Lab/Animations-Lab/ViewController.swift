//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var animationOption: UIView.AnimationOptions = UIView.AnimationOptions.autoreverse
    
    lazy var blueSquare: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "brendon")
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .fill
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 5
        return buttonStack
    }()
    
    lazy var upButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move box up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move box down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move box left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateLeft(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move box right", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateRight(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var timeStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 2.0
        stepper.maximumValue = 10.0
        stepper.minimumValue = 0.0
        stepper.stepValue = 1.0
        stepper.addTarget(self, action: #selector(timeStepper(sender:)), for: .touchUpInside)
        return stepper
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Current duration: \(timeStepper.value)"
        return label
    }()
    
    lazy var distanceStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 100.0
        stepper.maximumValue = 300.0
        stepper.minimumValue = 10.0
        stepper.stepValue = 10.0
        stepper.addTarget(self, action: #selector(offsetStepper(sender:)), for: .touchUpInside)
        return stepper
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Current distance: \(distanceStepper.value)"
        return label
    }()
    
    private func timeStepperConstraints() {
        view.addSubview(timeStepper)
        timeStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeStepper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            timeStepper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func distantStepperConstraints() {
        view.addSubview(distanceStepper)
        distanceStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            distanceStepper.topAnchor.constraint(equalTo: timeStepper.bottomAnchor, constant: 8),
            distanceStepper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func timeLabelConstraints() {
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            timeLabel.leadingAnchor.constraint(equalTo: timeStepper.trailingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
    private func distanceLabelConstraints() {
        view.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            distanceLabel.leadingAnchor.constraint(equalTo: distanceStepper.trailingAnchor, constant: 20),
            distanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
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
        view.backgroundColor = .systemBackground
        addSubviews()
        configureNavBar()
        configureConstraints()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Animation"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(showSettings(_:)))
    }
    
    @objc
    private func showSettings(_ sender: UIBarButtonItem) {
        // segue to setting VC
        let settingVC = SettingsVC()
        settingVC.delegate = self
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @IBAction func animateSquareUp(sender: UIButton) {
        print(animationOption)
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - CGFloat(distanceStepper.value)
        UIView.transition(with: blueSquare, duration: timeStepper.value, options: [animationOption], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffet = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffet + CGFloat(distanceStepper.value)
        UIView.transition(with: blueSquare, duration: timeStepper.value, options: [animationOption], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func animateLeft(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset - CGFloat(distanceStepper.value)
        UIView.transition(with: blueSquare, duration: timeStepper.value, options: [animationOption], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func animateRight(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset + CGFloat(distanceStepper.value)
        UIView.transition(with: blueSquare, duration: timeStepper.value, options: [animationOption], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func timeStepper(sender: UIStepper) {
        timeLabel.text = "Current duration: \(sender.value)"
    }
    
    @IBAction func offsetStepper(sender: UIStepper) {
        distanceLabel.text = "Current distance: \(sender.value)"
    }
    
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonStackView)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
    }
    
    private func addStackViewSubviews() {
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
    }
    
    private func configureConstraints() {
        constrainBlueSquare()
        constrainUpButton()
        constrainDownButton()
        constrainButtonStackView()
        constrainLeftButton()
        constrainRightButton()
        timeStepperConstraints()
        distantStepperConstraints()
        timeLabelConstraints()
        distanceLabelConstraints()
    }
    
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
    }
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func constrainLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftButton.heightAnchor.constraint(equalToConstant: 20),
            leftButton.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -20)
        ])
    }
    
    private func constrainRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.heightAnchor.constraint(equalToConstant: 20),
            rightButton.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -20),
            rightButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
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

extension ViewController: AnimationDelegate {
    func animation(int: UInt) {
        animationOption = UIView.AnimationOptions(rawValue: int)
    }
}
