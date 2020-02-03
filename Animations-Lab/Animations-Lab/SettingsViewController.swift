//
//  SettingsViewController.swift
//  Animations-Lab
//
//  Created by casandra grullon on 2/3/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

enum AnimationStyle: Int {
    case curveEaseIn = 0
    case curveEaseOut = 16
    case repeated = 8
    case curveLinear = 196608
}

class SettingsViewController: UIViewController {
    
    private var animations = ["curveEaseIn", "curveEaseOut", "repeat", "curveLinear"]
    
    public var selectedStyle: String?
    
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
        
        
    }
}
