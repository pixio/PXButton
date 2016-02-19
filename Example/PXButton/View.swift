//
//  DemoView.swift
//  PXImageView
//
//  Created by Dave Heyborne on 2.17.16.
//  Copyright © 2016 Dave Heyborne. All rights reserved.
//

import UIKit

class View: UIView {
    private let _centerView: UIView
    let finnButton: PXButton
    let jakeButton: PXButton
    
    override init(frame: CGRect) {
        _centerView = UIView()
       jakeButton = PXButton()
       finnButton = PXButton()
        super.init(frame: frame)
        
        _centerView.translatesAutoresizingMaskIntoConstraints = false
        
        
       jakeButton.backgroundColor = UIColor.greenColor()
       jakeButton.usesSubtleGradient = true
       jakeButton.setImage(UIImage(named: "jake"), atPosition: PXButtonIconPosition.Left, forState: UIControlState.Normal, tint: false)
       jakeButton.setTitle("Jake the Dog", forState: UIControlState.Normal)
       jakeButton.cornerRadius = 4.0
       jakeButton.translatesAutoresizingMaskIntoConstraints = false
        
       finnButton.backgroundColor = UIColor.orangeColor()
       finnButton.usesSubtleGradient = true
       finnButton.setImage(UIImage(named: "finn"), atPosition: PXButtonIconPosition.Right, forState: UIControlState.Normal, tint: false)
       finnButton.setTitle("Finn the Human", forState: UIControlState.Normal)
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
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-spacing-[_centerView]-spacing-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[jakeButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[finnButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[jakeButton(buttonHeight)]-spacing-[finnButton(buttonHeight)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraint(NSLayoutConstraint(item: _centerView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0))
        
        super.updateConstraints()
    }
}
