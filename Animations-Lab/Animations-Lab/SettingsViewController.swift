//
//  SettingsViewController.swift
//  Animations-Lab
//
//  Created by casandra grullon on 2/3/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

enum AnimationStyle: String {
    case transitionFlipFromLeft = "transitionFlipFromLeft" //0
    case transitionFlipFromRight = "transitionFlipFromRight" //16
    case repeated = "repeat" //8
}

protocol AnimationStyleDelegate: AnyObject {
    func didSelectAnimationStyle(style: AnimationStyle.RawValue)
}

class SettingsViewController: UIViewController {
    
    private var animations = [AnimationStyle.transitionFlipFromLeft.rawValue, AnimationStyle.transitionFlipFromRight.rawValue, AnimationStyle.repeated.rawValue]
    
    public var selectedStyle: String?
    
    weak var delegate: AnimationStyleDelegate?
    
    public var pickerView: UIPickerView = {
       let pv = UIPickerView()
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPickerViewConstraints()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setupPickerViewConstraints() {
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
        
}
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animations[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let style = animations[row]
        selectedStyle = style
        delegate?.didSelectAnimationStyle(style: style)

        
    }
}
