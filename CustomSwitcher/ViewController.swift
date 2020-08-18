//
//  ViewController.swift
//  CustomSwitcher
//
//  Created by   admin on 18.08.2020.
//  Copyright © 2020 Evgeny Ezub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    var customSwitcher: CustomSwitcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// set selected state for switcher 0 or 1 if you get 2 items
        customSwitcher = CustomSwitcher(withSelected: 0)
        ///the array consist of 2 labels, make sure you don't use long text
        customSwitcher.items = ["One", "Two"]
        setupSwitcher()
        
    }
    
    private func setupSwitcher() {
        
        customSwitcher.delegate = self
        
        ///I just add shadow to give nice  appearence
        customSwitcher.layer.shadowColor = UIColor(red: 0.013, green: 0.016, blue: 0.017, alpha: 0.66).cgColor
        customSwitcher.layer.shadowOffset = CGSize(width: 2, height: 2)
        customSwitcher.layer.shadowRadius = 10
        customSwitcher.layer.shadowOpacity = 1
        
        ///add constraints in view
        ///the width is 2x height
        view.addSubview(customSwitcher)
        customSwitcher.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(customSwitcher.snp.height).multipliedBy(2)
        }
    }
    
}

//MARK: - CustomSwitcherDelegate
extension ViewController: CustomSwitcherDelegate {
    
    /// action called once swithcer is pressed
    func itemSelected(at index: Int) {
           print(index)
       }
}

