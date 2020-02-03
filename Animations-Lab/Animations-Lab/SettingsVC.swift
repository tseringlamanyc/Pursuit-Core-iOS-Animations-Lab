//
//  SettingsVC.swift
//  Animations-Lab
//
//  Created by Tsering Lama on 2/3/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

protocol AnimationDelegate: AnyObject {
    func animation(int: UInt)
}

class SettingsVC: UIViewController {
    
    lazy var pickerView: UIPickerView = {
        let pickerview = UIPickerView()
        return pickerview
    }()
    
    private var animateOptions = ["curveEaseIn", "curveEaseOut", "Repeat", "curveLinear", "transitionFlipFromLeft"]
    
    weak var delegate: AnimationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func setupPickerView() {
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension SettingsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animateOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animateOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let animationChoice = animateOptions[row]
        delegate?.animation(int: UInt(row))
        print(row)
    }
}
