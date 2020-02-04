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

enum AnimationChoice: Int {
    case curveEaseIn = 65536
    case curveEaseOut = 0
    case Repeat = 8
    case curveLinear = 196608
    case transitionFlipFromLeft = 1048576
}

class SettingsVC: UIViewController {
    
    var defaultAnimation = AnimationChoice.curveEaseIn
    
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
//        let animationChoice = animateOptions[row]
//        delegate?.animation(int: UInt(row))
//        print(row)
        switch row {
        case 0:
            defaultAnimation = .curveEaseIn
            delegate?.animation(int: UInt(defaultAnimation.rawValue))
        case 1:
            defaultAnimation = .curveEaseOut
            delegate?.animation(int: UInt(defaultAnimation.rawValue))
        case 2:
            defaultAnimation = .Repeat
            delegate?.animation(int: UInt(defaultAnimation.rawValue))
        case 3:
            defaultAnimation = .curveLinear
            delegate?.animation(int: UInt(defaultAnimation.rawValue))
        case 4:
            defaultAnimation = .transitionFlipFromLeft
            delegate?.animation(int: UInt(defaultAnimation.rawValue))
        default:
            print("Sup")
        }
    }
}
