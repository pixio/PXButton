//
//  DemoView.swift
//  PXImageView
//
//  Created by Dave Heyborne on 2.17.16.
//  Copyright © 2016 Dave Heyborne. All rights reserved.
//

import UIKit

class View: UIView {
    fileprivate let _centerView: UIView
    let finnButton: PXButton
    let jakeButton: PXButton
    
    override init(frame: CGRect) {
        _centerView = UIView()
       jakeButton = PXButton()
       finnButton = PXButton()
        super.init(frame: frame)
        
        _centerView.translatesAutoresizingMaskIntoConstraints = false
        
        
       jakeButton.backgroundColor = UIColor.green
       jakeButton.usesSubtleGradient = true
       jakeButton.setImage(UIImage(named: "jake"), at: PXButtonIconPosition.left, for: UIControlState(), tint: false)
       jakeButton.setTitle("Jake the Dog", for: UIControlState())
       jakeButton.cornerRadius = 4.0
       jakeButton.translatesAutoresizingMaskIntoConstraints = false
        
       finnButton.backgroundColor = UIColor.orange
       finnButton.usesSubtleGradient = true
       finnButton.setImage(UIImage(named: "finn"), at: PXButtonIconPosition.right, for: UIControlState(), tint: false)
       finnButton.setTitle("Finn the Human", for: UIControlState())
       finnButton.iconSize = 40.0
       finnButton.cornerRadius = 4.0
       finnButton.translatesAutoresizingMaskIntoConstraints = false
       finnButton.titleLabel?.adjustsFontSizeToFitWidth = true
       finnButton.titleLabel?.font = UIFont(name: "futura", size: 18.0)
        
        addSubview(_centerView)
        _centerView.addSubview(jakeButton)
        _centerView.addSubview(finnButton)
        
        setNeedsUpdateConstraints()
    }
    
    // NOT IMPLEMENTED
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        removeConstraints(constraints)
        
        let views: [String : UIView] = ["jakeButton" : jakeButton, "finnButton" : finnButton, "_centerView" : _centerView]
        let metrics: [String : Int] = ["spacing" : 60, "buttonHeight" : 48]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-spacing-[_centerView]-spacing-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[jakeButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[finnButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[jakeButton(buttonHeight)]-spacing-[finnButton(buttonHeight)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraint(NSLayoutConstraint(item: _centerView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))
        
        super.updateConstraints()
    }
}
