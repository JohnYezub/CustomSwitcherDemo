//
//  CustomSwitcher.swift
//  CustomSwitcher
//
//  Created by   admin on 18.08.2020.
//  Copyright © 2020 Evgeny Ezub. All rights reserved.
//

import UIKit
import SnapKit

protocol CustomSwitcherDelegate: class {
    func itemSelected(at index: Int)
}

final class CustomSwitcher: UIView {
    
    // MARK: - Properties
    
    private var cornerRadius: CGFloat!
    
    ///THIS SWITCHER IS FOR 2 LABELS
     var items = ["Map","List"]
    
    ///the array of labels for switcher
    private var itemLabels = [UILabel]()
    
    ///the delegate call method once the switcher is pressed
    weak var delegate: CustomSwitcherDelegate?
    
    ///selected item
    var selectedItemIndex = 0 {
        didSet {
            selectedItem(at: selectedItemIndex)
        }
    }
    
    // MARK: - Appearence
    
    ///I put all a labels in a StackView
    private let contentStackView = UIStackView()
    
    ///the selected item appearence
    private let selectionView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.221, green: 0.235, blue: 0.25, alpha: 1).cgColor
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.cornerRadius = self.frame.height / 2
        ///configure swithcer
        configure()
        
        ///setup selection appearence on init
        setupSelectionView()
        
    }
    
    // MARK: Init and deinit
    
    init(withSelected itemIndex: Int) {
        super.init(frame: .zero)
        print(#function)
        ///update selected item on init
        self.selectedItemIndex = itemIndex
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    
    private func configure() {
        print(#function)
        itemLabels = items.enumerated().map { idx, item in
            let label = UILabel()
            label.text = item
            label.font = UIFont(name: "Helvetica", size: 12)
            label.textColor = UIColor(red: 0.424, green: 0.439, blue: 0.455, alpha: 1)
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.isUserInteractionEnabled = true
            label.tag = idx
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemLabelTap))
            label.addGestureRecognizer(tapGesture)
            
            return label
        }
        
        ///put all items into StackView
        configureStackView()
        
        layer.backgroundColor = UIColor(red: 0.05, green: 0.06, blue: 0.07, alpha: 1).cgColor
        layer.cornerRadius = cornerRadius
       // layer.borderWidth = 1
       // layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
    }
    
    private func configureStackView() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentStackView.axis = .horizontal
        contentStackView.distribution = .fillEqually
        itemLabels.forEach { contentStackView.addArrangedSubview($0) }
    }
    
    private func setupSelectionView() {
        print(#function)
        addSubview(selectionView)
        let theFrame = self.bounds.insetBy(dx: 1, dy: 1)
        selectionView.layer.cornerRadius = theFrame.height / 2
        
        selectionView.snp.makeConstraints { (make) in
            make.center.equalTo(itemLabels[selectedItemIndex].snp.center)
            make.width.equalTo(theFrame.height)
            make.height.equalTo(theFrame.height)
        }
        sendSubviewToBack(selectionView)
        print(selectionView.frame)
        
        itemLabels[selectedItemIndex].textColor = .white
    }
    
    //MARK: - tapGesture action
    @objc private func itemLabelTap(_ tapGesture: UITapGestureRecognizer) {
        if let view = tapGesture.view {
            selectedItemIndex = view.tag
            delegate?.itemSelected(at: selectedItemIndex)
            
        }
    }
    
    ///setup selection each time the switcher is pressed
    
    private func selectedItem(at index: Int) {
        
        ///reset all label text color
        itemLabels.forEach(resetLabel)
        
        ///setup selected label and view
        let targetLabel = itemLabels[index]
        UIView.transition(with: targetLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            targetLabel.textColor = .white
            self.selectionView.center = targetLabel.center
        },
        completion: nil)
    }
    
    ///reset label color fot all items
    private func resetLabel(_ label: UILabel) {
    
        label.textColor = UIColor(red: 0.424, green: 0.439, blue: 0.455, alpha: 1)
    }
    
    ///update selected item index
    public func setItemSelected(_ index: Int) {
        ///make sure that index is in items count
        guard index < items.count else {
            return
        }
        selectedItemIndex = index
    }
}
