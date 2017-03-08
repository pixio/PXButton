//
//  PXSwiftViewController.swift
//  PXImageView
//
//  Created by Dave Heyborne on 2.17.16.
//  Copyright © 2016 Dave Heyborne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var contentView: View {
        return view as! View
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func loadView() {
        super.loadView()
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PX Button"
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        edgesForExtendedLayout = UIRectEdge()
        
        contentView.jakeButton.addTarget(self, action: #selector(ViewController.pressed(_:)), for: UIControlEvents.touchUpInside)
        contentView.finnButton.addTarget(self, action: #selector(ViewController.pressed(_:)), for: UIControlEvents.touchUpInside)
    }
    
    func pressed(_ button: PXButton) {
        button.setImage(button.image(for: UIControlState())?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
        button.tintColor = UIColor(hue: CGFloat(drand48()), saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
}
