//
//  TestAutolayoutController.swift
//  ProRevise:GCSE
//
//  Created by Jake Smith on 13/09/2018.
//  Copyright © 2018 Nebultek. All rights reserved.
//

import UIKit

class TestAutoLayoutController: UIViewController {
    
    let logo = UIView()
    let bogo = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        bogo.backgroundColor = UIColor.blue
        logo.backgroundColor = UIColor.green
        bogo.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logo)
        view.addSubview(bogo)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[logo(==100)][bogo]|", options: [], metrics: nil, views: ["logo":logo,"bogo":bogo]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[logo]-|", options: [], metrics: nil, views: ["logo":logo]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[bogo]-|", options: [], metrics: nil, views: ["bogo":bogo]))
        
        
        
    
    }
    
    
}


